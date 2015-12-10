From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] push: Use "last one wins" convention for --recurse-submodules
Date: Thu, 10 Dec 2015 15:44:14 -0800
Message-ID: <CAGZ79kaehf+o9qwznTZyG743OrO2EerEO0PAWois4L2G6=933w@mail.gmail.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<1449148235-29569-2-git-send-email-mac@mcrowe.com>
	<CAGZ79kbxvrMHnJx9iACus44+rmFf6ZNFPArrpVhNr6ZTDj+XOg@mail.gmail.com>
	<xmqq8u51ho27.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Crowe <mac@mcrowe.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:44:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Asl-0002E8-QL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbLJXoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:44:15 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33420 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbLJXoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:44:14 -0500
Received: by mail-ig0-f182.google.com with SMTP id mv3so29156878igc.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 15:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DUuDCAeqdN4L5ZAgnDX7LdIzifUxzZJuP3PfVGLf0W4=;
        b=e4k+2xSTk9cj6IaGwiV5jpg9M4y/gVkOHhw4q0F+iWk13Q7Uy8t2mF86XFuu8AQqvM
         TAX2IdNChBbdSr6JJaHoCqztUu6ss9h7pSnK1ye4+lA+kiwDkgvId55eVF6IeAeDq2ZZ
         Hnwj847VsX6TLoxh7HV8VmuQ5oAcJnxDqR/vh2xo6IKLS+bjP185+FMJ9QGiYQoQtJ+Q
         epgqGpOIWDBe6MBwZNJdSWcaQSrxe3yeSNd1WKPl4xcMb4hpT2t5Hd6neE7FKCyphEeF
         ZF5/fVoz6rZaRihFeIMyDTvGeT41Q0e+TOLhaQtopLjLbYt/g3ciumlHENfKRjH9S8LV
         WgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DUuDCAeqdN4L5ZAgnDX7LdIzifUxzZJuP3PfVGLf0W4=;
        b=R+QPMvt1DleAddUlICw6yIKufamNYZFGE3fp5Yne1xvhi0EL2CZTUwF+rvdQ46XPLE
         neMCxM2LXKt1d6y2BnKchlLGPvO6P8iv3xitaHfyVfcWNOn3YouJOs83luF9c+cmw71s
         uu3q3BOkWd72peLj/3XD0iEwDDp+aiIQZVgJjFf80cSFOUe9YdmIyS+b8NBYV+GsKzqk
         ZizSYRRSTujrOLBbR0v1btcPnKU1AiRQwfcZaCoCp+dDzqdjc2UDLkJKs/ZAa9s+PHML
         saMiN5BYF5jzOuL96Uz9LxR82sdRRJmxkWm53WitCPpU15VPzs26YtLl3RNT0cZsfsUi
         x3ow==
X-Gm-Message-State: ALoCoQl4ZVxEq0vIUpTQh2fqfEJYTv6+zSr4aOqjqeeM78MW28BnupxS2DFVxkj7X1P/TGawYAqjQkKT6SQvKrcN+4JPKU0OpbpKT6seS2XA8nUDJfcm41Q=
X-Received: by 10.50.20.8 with SMTP id j8mr1921439ige.94.1449791054114; Thu,
 10 Dec 2015 15:44:14 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Thu, 10 Dec 2015 15:44:14 -0800 (PST)
In-Reply-To: <xmqq8u51ho27.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282244>

On Thu, Dec 10, 2015 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> +               git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
>>> +               # Check that the submodule commit did not get there
>>
>> Do we want to check here that the supermodule commit did get there,
>> instead of only checking the submodule?
>
> Hmm, your point is that when the push succeeds, (1) the command
> should return with 0 status, (2) the branch in the superproject
> should update to the right commit, and (3) none of the submodule
> should be affected, and the current test does not check the second
> one?
>
> I think that makes sense, in somewhat a paranoid way ;-).

I was just comparing to the case before,
where we had

> +               # Check that the supermodule commit did get there
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master &&

which I just skimmed over and mistakenly thought it would be the same check as
before (checking the superproject did *not* get there).

So looking at it, the superprojects history would need no update,
the commit stays the same, so no need check for it to stay the same.

So, sorry for the noise.
