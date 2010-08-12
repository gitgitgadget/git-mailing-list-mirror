From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Thu, 12 Aug 2010 16:19:39 -0400
Message-ID: <AANLkTikDvcn4eFDdkv26ADzsipwD_ofkdYwu_0abeLA3@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<vpqsk2kjks7.fsf@bauges.imag.fr>
	<AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
	<7viq3fsirv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeFh-0006hX-7b
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760509Ab0HLUTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:19:43 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:54803 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754969Ab0HLUTm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 16:19:42 -0400
X-AuditID: 1209190e-b7bbeae000000a09-5f-4c64575f55df
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 94.F3.02569.F57546C4; Thu, 12 Aug 2010 16:19:43 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7CKJfxe012501
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 16:19:41 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7CKJeTN009016
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 16:19:41 -0400 (EDT)
Received: by gxk23 with SMTP id 23so581990gxk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:19:40 -0700 (PDT)
Received: by 10.231.183.10 with SMTP id ce10mr587294ibb.96.1281644379899; Thu,
 12 Aug 2010 13:19:39 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Thu, 12 Aug 2010 13:19:39 -0700 (PDT)
In-Reply-To: <7viq3fsirv.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhWWNLgVlxO7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153407>

>> First of all, as you point out 'git add foo.pdf' works where foo.pdf
>> has been explicitly ignored, while in contrast 'git add dir/file'
>> fails when file has only been indirectly ignored because it is in an
>> ignored directory. =A0In the former case, the user explicitly specif=
ied
>> a policy for that file. =A0In the later case, the policy is only
>> indirectly expressed because that file happens to be in an ignored
>> directory.
>
> Sorry, but I don't get this argument. =A0When the user says "everythi=
ng in
> this directory is ignored", why does it make it less direct than "thi=
s
> particular file is ignored"?
In general, I view the presence of a dir entry in a .gitignore as the
user setting a default policy for files in that directory, but the
user might actually mean for there to be some exceptions to that
policy.

=46or example, in my personal usage, when I ignore a directory but trac=
k
some files within it, this is because I don't want to specify an
ignore for every single other file in that directory.  Also note that
negated .gitignore entries don't seem to work in this case, i.e. a
=2Egitignore with contents
dir
!dir/file
won't actually let file be addable again.

In contrast, when I add dir/file to a .gitignore, there is no doubt
that I want to ignore that particular file.

Does that make more sense?

Greg
