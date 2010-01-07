From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] t7002: set test prerequisite "external-grep" if 
	supported
Date: Thu, 7 Jan 2010 20:27:39 +0700
Message-ID: <fcaeb9bf1001070527ra1570a0m12182db9bb029055@mail.gmail.com>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
	 <1262608455-4045-1-git-send-email-pclouds@gmail.com>
	 <7v4omyhc7h.fsf@alter.siamese.dyndns.org>
	 <7vy6ka8rmr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 14:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSsOx-0002Os-Pd
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 14:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0AGN1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 08:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171Ab0AGN1k
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 08:27:40 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64795 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0AGN1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 08:27:40 -0500
Received: by pzk1 with SMTP id 1so2925647pzk.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 05:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=fv+5YpsEs8kIvCmnyFtYga83qIxDE6jbDdUOhZDbv88=;
        b=VrjP+OJAkna5EtSPcV2yoxcR0/SwMhl4pn03W7fGRTSu69kK3EypVWChhEn6gE3nFH
         Qku7mbf3dOV9Wm3+/JgGQNsM+szXctsKnemw03XVZriQD30lMOC8C3Qku7oTw5uW1YpO
         2webhFXpWGJfrr+9g1/ncnSePakhza9zNzyYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=as/UzRvwpc3a/u1Bzn0eAK7rMeeiEd1kc4gVFUEs/niA+o6/mRIF2VTQK36mEJi2lw
         x9MvUOvUeDQ/quXMGoD1Tm8ufrIbrJ8B60dn42WPLkCRDZ4xkAjhHpy4QEHuirdqdDsN
         VEair453XO4QXwOpWijiCP5Z27AbbwY7FMIso=
Received: by 10.114.248.33 with SMTP id v33mr808837wah.77.1262870859284; Thu, 
	07 Jan 2010 05:27:39 -0800 (PST)
In-Reply-To: <7vy6ka8rmr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136343>

On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
>  So by writing the test to check the desired outcome, instead of writing it
>  for the particular implementation of using external grep optimization, you
>  will catch both kinds of breakages.
>
>  Perhaps something like this (untested, of course)?
>
>  test_expect_success 'strings in work tree files are not found for skip-wt paths' '
>         no="no such string in the index" &&
>         test_must_fail git grep -e "$no" --cached file &&
>         git update-index --skip-worktree file &&
>         echo "$no" >file &&
>         test_must_fail git grep -e "$no" file &&
>         git update-index --no-skip-worktree file &&
>         git grep -e "$no" file
>  '
>

Very well reasoned. I'd say go for it!

Tested-by: me
-- 
Duy
