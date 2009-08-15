From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Fri, 14 Aug 2009 19:52:46 -0500
Message-ID: <qZXfoQ5Gp5jKnRfKM6ee07YVX-hyS2HsJmQwAYdPVHw92cOuUcufJA@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: nico@cam.org, gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 15 02:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc7WL-0002Gm-31
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 02:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbZHOAxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 20:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZHOAxL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 20:53:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57186 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbZHOAxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 20:53:10 -0400
Received: by mail.nrlssc.navy.mil id n7F0qkdJ001466; Fri, 14 Aug 2009 19:52:46 -0500
In-Reply-To: <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Aug 2009 00:52:46.0231 (UTC) FILETIME=[B43B4270:01CA1D42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125971>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 14 Aug 2009, Brandon Casey wrote:
> 
>> Some compilers produce errors when arithmetic is attempted on pointers to
>> void.  So cast to uintptr_t when performing arithmetic on void pointers.
> 
> I am confused.  Is sizeof(*(uintptr_t)NULL) not larger than 1, and as a 
> consequence ((uintptr_t)p)+1 not different from ((void *)p)+1?

If you try this:

   printf("NULL + 1: %u\n", (void*)NULL + 1);

the MIPSpro compiler complains like:

   The expression must be a pointer to a complete object type.

        printf("NULL + 1: %u\n", (void*)NULL + 1);
                                 ^

   1 error detected in the compilation of "test.c".


Compilers other than gcc at least issue a warning, if they do
not also fail.

-brandon
