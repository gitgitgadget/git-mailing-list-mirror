From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Git (svn) merge - but ignore certain commits?
Date: Thu, 8 Jan 2009 15:00:53 -0500
Message-ID: <eaa105840901081200i2738dael10e2db35b7cb4750@mail.gmail.com>
References: <49562749.9060705@sneakemail.com>
	 <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>
	 <49663CA2.90102@sneakemail.com>
	 <eaa105840901081029h220e06e4m1a1af693e908751e@mail.gmail.com>
	 <4966513C.1010707@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:36:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL15B-00032j-Fu
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 21:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbZAHUA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbZAHUA4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 15:00:56 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:58398 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbZAHUAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 15:00:55 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2903717ywe.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=CuFij646dlbTAg8ORD2USL+0UtKt3NnrSQ7kun5KmTw=;
        b=AcSKx3br+yeSJ0woH8mSwl1fDY/tJxOBHj7Nc37RUTP46fAcy6hGLNYqKckmCHh2Fm
         YET7uZssEY1yAZ45qjad6VjXV8b7zY2JB+WbqGC+F1chBmV8TN3p7MAKl9n20+to4xD6
         Qf62PMMuCVBcBJ30GPMxYYRIgj9Gy+xLmVTmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=MbOcbK+ece/A4MqavuYy6FnAkTecqJlgMTptrOLTeAUUvSB4Nu0r4Jv6O96B92Bu7L
         pY3lvzOA0qR2Kh8HyrFeieh7Qo+Sj4pyP/hVid57gri5up0mz3YjN2Ue8u6v43MK3KV3
         TUEi8ijLv7edeMh5DFdy4uJpV2mw8K4nhR+mg=
Received: by 10.65.83.1 with SMTP id k1mr2364737qbl.128.1231444853793;
        Thu, 08 Jan 2009 12:00:53 -0800 (PST)
Received: by 10.64.210.7 with HTTP; Thu, 8 Jan 2009 12:00:53 -0800 (PST)
In-Reply-To: <4966513C.1010707@sneakemail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 5efb1d3846e59ce4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104959>

On Thu, Jan 8, 2009 at 2:17 PM, "Peter Valdemar M=F8rch (Lists)" wrote:
>
> E.g.:
>
> ---A---B---C---D--+ "master"
>    \--E---F---G-/  "branch"
>
> Here I want F and G merged back to "master", but *not* E (which is a
> quick-and-dirty but safe version of B).

Stop and think about that for a second.

Rephrased, "I want to cherry pick a few commits to master using the
merge command".

That sounds rather silly when I put it that way. What do you really wan=
t? Hmm.

Maybe you want to cherry pick those commits. Maybe (if this is still
an unpublished branch), you want to "git rebase --onto B E" your
branch to get the non-dirty version of E, then merge.

Or maybe you do want to merge, but you're getting confused by not
seeing the automatic conflict markers. You could merge --no-commit the
branch, fix the conflicts (E conflicts logically with B, even if 'git
merge' doesn't automatically mark it as such -- 'git revert -n E' may
even do most of the work), and only then commit the merge revision.
Repeated merges from this state will not keep trying to import E
(since E is already in the history).

Peter Harris
