From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Mon, 30 Nov 2015 16:47:05 -0800
Message-ID: <CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Z69-0005lV-0p
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 01:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbLAArI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 19:47:08 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33595 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbLAArH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 19:47:07 -0500
Received: by ykdv3 with SMTP id v3so206251535ykd.0
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 16:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DYsHrlH8CYTw2aeAyLgrFe6uG0EtLjnFdOvC1G7GwIw=;
        b=B/3nAJUFbQovh+/BxyVPG+LyM1IC0+Hhx4eVQT5K6/pXWTBQUIamwzY7fxEBTbLsA9
         XvfpPOPslAWdsfkWwm4IIwCotyBFxmzdLiF4tBGPLkzF35PJXLdF9oInhKiCo3ZIsR0I
         hYUGgBzkuHRKxnGP2KXXeqAUguKLkIFQnnbgtURW5XqklZSFvAzF05UbAMrV/dsQ52m2
         EfTPby+i6NItB7/I+AlAMhW9moQhqxXZFR1sK3th7IOBzj7o6LsZ3i7zZi5lhBt05n+d
         eiYiiNIHA1TD1BbUuR2WNXuE6aWt9uWNAoo0KpWHpbb1qjvavnLdDaetEXMc5OShpyPE
         j+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DYsHrlH8CYTw2aeAyLgrFe6uG0EtLjnFdOvC1G7GwIw=;
        b=bp/KANYec/CL0Gng2CkXOmx1nHMUTcRfMtI3BTXuq7LZurXttri3iqaBdQ/2Bxev8j
         bfoaSt14IowDAxD9KkYRir5MqE7Gko8K0JtrL7lOTk2xOxb+70/nLD7SLHAztOdnqZdv
         TEywDjqZXJ2Rv+gT4ehVkWJBPSDAGsLimxjjSIZv2EecF3GW4T8igEDA4nn28+zJ4Pl/
         0z7/u7GvmYdlC9Tq48kY7dy3wTmt6jXIg1LPRoKflILIZLNSHMMjPCwtbjPQ0+BHrvoe
         9cqpWkfOlpCi3ZWJFZ45HU426skISHJGSg0VEW4PwRV26YqCAQRpClrJkkLRFpi+iQRx
         04Qw==
X-Gm-Message-State: ALoCoQmP1o2bzN7pwRpFcFOjhvB4IGy04TGk0kAgwXWsBUEyBsZNnKFbDwsFxaiLS+EWWKDAPAB3
X-Received: by 10.13.214.19 with SMTP id y19mr56528936ywd.63.1448930825819;
 Mon, 30 Nov 2015 16:47:05 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Mon, 30 Nov 2015 16:47:05 -0800 (PST)
In-Reply-To: <xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281828>

On Mon, Nov 30, 2015 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +cc Junio, Duy
>>
>> So cloning from an arbitrary SHA1 is not a new thing I just came up with,
>> but has been discussed before[1].
>>
>> Junio wrote on Oct 09, 2014:
>>> This is so non-standard a thing to do that I doubt it is worth
>>> supporting with "git clone".  "git clone --branch", which is about
>> "> I want to follow that particular branch", would not mesh well with
>>> "I want to see the history that leads to this exact commit", either.
>>> You would not know which branch(es) is that exact commit is on in
>>> the first place.
>>
>> I disagree with this. This is the *exact* thing you actually want to do when
>> dealing with submodules.
>
> Yup, I know, but I do not think the above disagrees with you (read
> again ;-).  It merely says "--branch" option to "clone" is not a
> good place to add a new "clone at this single commit" mode of
> operation.

Ok. So maybe a bit of bike shedding time:

How does

    git clone --detached-head <sha1>

sound? I would imagine that this would either present you with a fresh clone
with a detached head at the specified sha1, or if the server doesn't support
getting a specific sha1, it would error out.

Having a command like that we could then use it inside of the submodule
code as  git clone --detached-head is surely compatible with --depth.
In case the --detached-head clone fails, we can still use the old behavior,
warning about --depth not being supported and ignoring --depth in
further commands and just performing a standard clone.

>
> In order to propagate "--single-branch" thru "--recurse-submodules",
> I suspect that you would need to teach "clone" a new option that is
> different from "--branch" that allows you to clone the history
> starting from the commit recorded in the tree of the superproject in
> the submodule.  That would be orthogonal to "--depth $n", of course,
> in other words, a top-level "--single-branch --recurse-submodules"
> clone should trigger the "history reachable from a specified commit"
> mode of clone in submodules, and if the top-level one specified the
> "--depth" option, the lower-level ones can limit the depth
> accordingly.
>
>
>
>
