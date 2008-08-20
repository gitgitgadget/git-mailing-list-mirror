From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: git for-each-ref crashes for %(body) with tags
Date: Wed, 20 Aug 2008 15:28:41 -0300
Message-ID: <f329bf540808201128r2d21c40cr37eb63a6706ac0aa@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 20:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsRz-0006vT-Ff
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYHTS2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYHTS2o
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:28:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:51768 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYHTS2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:28:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so268437yxm.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=SeHHYoDRz/VBz3tBqhpPar1g5ha5Sfqn8ha+BiZIkDw=;
        b=WbdAs3P4te6s7vIh3rah9N20jnaYhKJglht/OO5iSod/9TEhoiosoBHP+NRSHt+a7Y
         2J0SnDbFHIaxbXr8hMypL2Jwbnhbu3Q6wC+jSQ4jtgIeyV1y1thG1OLQ+CkeHommExnv
         8uvhxI0HOrCuYQ82f8X+sPsEL4ZQ9oiYszly8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=byAyM6TzH8F+aRiXtDbVpPaU4K7+CK1eFLMxgrQh3xowU/N4ucI7ZjrhM6KXe6egxi
         h12Xiu+zyimDoKoj/RErg4TU6vgou7uDc590LxbcXm7xpe2L1cigfW3CKS6/4DunopCp
         NY6OgviTa6JhQG7S09oLvdLRMrgZFPgWjGCv4=
Received: by 10.114.154.12 with SMTP id b12mr584780wae.153.1219256921230;
        Wed, 20 Aug 2008 11:28:41 -0700 (PDT)
Received: by 10.115.109.8 with HTTP; Wed, 20 Aug 2008 11:28:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93008>

Hi,

see gdb trace below.   Unfortunately, I don't have a repo that I can
readily share to demonstrate this.

(gdb) r for-each-ref --format '%(body)' refs/tags
..

Breakpoint 1, grab_sub_body_contents (val=<value optimized out>,
deref=0, obj=<value optimized out>, buf=0x8146ad0, sz=161)
    at builtin-for-each-ref.c:494
494                             v->s = xstrdup(bodypos);
(gdb) p bodypos
$10 = 0x0

(gdb) n
496                             v->s = xstrdup(subpos);
(gdb) n

Program received signal SIGSEGV, Segmentation fault.
0x4d9ff013 in strlen () from /lib/tls/i686/cmov/libc.so.6

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
