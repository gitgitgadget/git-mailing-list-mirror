From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 5 Mar 2014 15:51:41 -0500
Message-ID: <CADgNjamZE5140U2vupgZMKyBq+e22+qOAAWKe=iRk7sxzhonvA@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
	<CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
	<xmqqa9d4ijmu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLIn5-0002hh-11
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 21:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbaCEUvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 15:51:43 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:50010 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbaCEUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 15:51:42 -0500
Received: by mail-wg0-f48.google.com with SMTP id b13so1975210wgh.31
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7s2O3Uo8tP2TR1pl7sky73c5+kZZ1Y7sskeMUop3Ya4=;
        b=lrXFIP5zp4DZf6C4MRNzAZWOUvz4WWS2Npu1fRP5mZXaCRARypxvBK5lBIB3zDVABr
         F6tvLyn82G29TXqi3mWRmDF2zRPcyMMD59i7doSr7YM2vR78P7yEfGnuM0S3VbldFduN
         6VF7WBZi9yictutdWxiLIA9K8jJpAMSrEbKobGtzu1oI9NAFz2OE7JgvVHqn1WqGk76z
         3X819FCZKycsQO9B1W4Ysq7wsjTfnjCDmitrDM5+fQL4Afl0ypG6W4jcnpThakEhH5D3
         k3JmDwxzqzFOC1s4zZhLxMCJTkGz8lFplLF8a6OFJHAx/tH35Ec35cNfSvUyH8o0h08N
         pLmA==
X-Received: by 10.195.13.17 with SMTP id eu17mr4380733wjd.24.1394052701080;
 Wed, 05 Mar 2014 12:51:41 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 5 Mar 2014 12:51:41 -0800 (PST)
In-Reply-To: <xmqqa9d4ijmu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243479>

On Wed, Mar 5, 2014 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If the user said "git merge" while another "git merge" is still
> outstanding, we would want to say "You have not concluded your
> previous merge" and die, and you presumably want to add the same
> "how to abort" message there.  Such a codepath is unlikely to be
> covered by existing advice.resolveConflict, and it sounds more
> natural, at least to me, to use a separate variable to squelch only
> the new "how to abort" part.

Alright, I don't mind using a separate variable. Though I think it'd
be good to keep the variable name slightly more general though, like
"advice.mergeHints", so that we could use the variable to cover other
merge hints in the future as well. Having one advice config/variable
for every single situation seems a bit overkill, and we would end up
with too many variables.
