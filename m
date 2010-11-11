From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 13:19:09 -0500
Message-ID: <AANLkTik_zW1ih=wF-dWTjsFhToNy1fOxy0XJXT1i1RTo@mail.gmail.com>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
 <201011111649.oABGnjca019731@no.baka.org> <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
 <20101111175836.GD16972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:19:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbkD-0001Vr-Md
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0KKSTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 13:19:31 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46099 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0KKSTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 13:19:30 -0500
Received: by ywc21 with SMTP id 21so123209ywc.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gTBKW/H5HHJ9OJW8KsZMfB74+R4dfGYtD4Qh8e4oyXg=;
        b=x9XeTSuJOG82M4faAWMxLkTZNAjGvxbVe1DLeXHqKd46JyddPAlO31i6Gxq/2zOD6o
         Zs3Fh9XB9NWaYgF7KX8agIXVr29IdLmTTxWsfDgj+W/Oo56heiPwgc+rQjM5p9Iz9qR6
         DY5yhyCRPGfdXrwodlTNnxc/IEFuXEODqIYYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hp5gS6pxJvHtzqxBxkNFN2nyVjn2vg4w0PANgQzfzAEPRpVRdDoBS7MgIwE+GfrrJC
         AUOFX8xi3lrLEnMQeklpsg3Th3ilZrIjZiRrpPvqzmYpaPOiz1UxYNK75V0DtwVAMu6A
         FRVBjVmw5nHzN3pRyREeMTcFuKGG7VD8+0/tc=
Received: by 10.223.118.132 with SMTP id v4mr477721faq.87.1289499569224; Thu,
 11 Nov 2010 10:19:29 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 10:19:09 -0800 (PST)
In-Reply-To: <20101111175836.GD16972@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161287>

On Thu, Nov 11, 2010 at 12:58 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Right. =A0In general, git operations that update HEAD also tend to ta=
ke
> the current branch along with them.
Ahhhh.... that's the missing piece, errr, one of the missing pieces,
to my puzzled brain.

So

$ git reset HEAD

updates HEAD (and whatever branch we are currently on) to point to
HEAD.  Except for mucking with the index, that seems pretty benign.

$ git reset HEAD^

updates HEAD (and whatever branch we are currently on) to point to
HEAD^, thus backing everything up by 1 commit.  As you pointed out,
this is dangerous/not a good idea/ if I've already pushed my
repository someplace.

In my particular case, after doing the "git reset HEAD^" on my
svn_to_git_wip branch, I later tried to switch back to master ("git
checkout master").  Git warned me about files that were not up to date
and refused to merge (but I thought I was checking out, not merging).
Since I knew what I was doing (we all know how sadly lacking in truth
that statement is now, don't we), I "git reset --hard" those files
(thus discarding my changes) and proceeded to check out master.

Light dawns on marble head.

Thanks again.

--wpd
