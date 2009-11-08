From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [RFC/PATCH 4/4] Re-implement 'git remote update' using 'git 
	fetch'
Date: Sun, 8 Nov 2009 23:23:18 +0100
Message-ID: <6672d0160911081423u41f7faa6md50190b04a71069d@mail.gmail.com>
References: <4AF6E865.1030900@gmail.com> <hd7c4k$aul$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 23:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GAP-0000Xd-SU
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbZKHWXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbZKHWXP
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 17:23:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:26082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbZKHWXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 17:23:14 -0500
Received: by fg-out-1718.google.com with SMTP id e12so992848fga.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=muIIjdvkIe5OSJedf0MkzsPwt+OsVzC3hArKTKn95ng=;
        b=fSZresbX/lRBr/H+hlgAxyihFIqJHEZE1RYKoea8OuuvxyAJT3s/A9oqATKhAQzQjB
         HvbmJPcQ451qytm3SfRaw1RNuxJZ0e0M5shlGhuwNWb+z2tMojN6j2gmklov/JRVlow+
         1oh8CUa3+uNMz6EtLIgBBr+gVUh32Krcb0EHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AxGgBU84pYXoa2Nslyv03Fwvs6Xm3rLOUR1HpiraZw0Bg1cx6yhxQyk4G9YvxMmhlm
         +lQ1sZzLp9eYgKFSjdlIHQ/xLVFsv2iPQzkVobzQCLAUzwyCaBxdA2mjBOXM7Mhm6DPN
         +hz/X4InUY0scdcVvzYmze37Di6j6D2M++S4w=
Received: by 10.204.162.204 with SMTP id w12mr7791201bkx.18.1257718998727; 
	Sun, 08 Nov 2009 14:23:18 -0800 (PST)
In-Reply-To: <hd7c4k$aul$3@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132422>

On Sun, Nov 8, 2009 at 10:10 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 11/08/2009 04:48 PM, Bj=C3=B6rn Gustavsson wrote:
>> There is one incompatibility: the skipDefaultUpdate configuration
>> variable will only be honored if remotes.default is not set (i.e.
>> when 'git remote update' will invoke 'git fetch --all', not when
>> it will invoke 'git fetch default').
>
> Rather than introducing this incompatibility, I'd rather see 'git rem=
ote
> update' deprecated (so that the code will one day go away for good) a=
nd, for
> now, leave duplicated functionality for the incompatible case.

I didn't check my facts properly before writing that commit message.
Looking again at the old code in builtin_remote.c (after a long break),=
 and
actually testing the behavior, I see that there is no incompatibility.

Both the old and the new code use skipDefaultUpdate only if remotes.def=
ault
is not set. If remotes.default is set, that list of remotes will be use=
d. Only
if remotes.default is not set, will 'git remote update' go through the =
list
of all remotes and filter away those that have skipDefaultUpdate set to=
 true.

Sorry for the confusion. I will correct the commit message in my re-rol=
l
of the patch.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
