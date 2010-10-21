From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 05/21] notes.h/c: Clarify the handling of notes objects
 that are == null_sha1
Date: Thu, 21 Oct 2010 12:54:05 -0500
Message-ID: <20101021175404.GC11328@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <1287626936-32232-6-git-send-email-johan@herland.net>
 <20101021051232.GA2413@burratino>
 <201010211513.06176.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 19:58:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8zOp-0007vE-6X
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 19:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab0JUR5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 13:57:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49908 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641Ab0JUR5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 13:57:53 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so3221ywk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=69o698A3p8u2VWmGBzvRpS4dcx5vgoDMnsowK8IRNmw=;
        b=KuTZehoiOU0+jSSshuuciZ8g+m8klzG1YI1yUV/wqsSy+LK8kR5xwHwBcsVAMfZ2p+
         UVeKonahXj81f/D6thra5IRKrrUIMLcJVEU5aeJhn3GUmfXkyusl8YGKF01qjfcrh12b
         B5/c+fWmkejBHJfrmJ/CRcFenQln0UWCg8YfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z+AJEatGgAkyjRniLanERmMSDT0HuThRl1zuWWDd0zT35z5cH/1w8/1RxzFw+ZXWpf
         fAf8sif5uagj2uYDP6XKHFkydDi/lrBSgrtS/d9bPSbudvt/NNJa/mCH+yzCweZJW4Jb
         6HPj8MfTR2Y6XWZ23MPsPEQdGSPqBbtfn6f08=
Received: by 10.103.161.6 with SMTP id n6mr2018609muo.18.1287683872021;
        Thu, 21 Oct 2010 10:57:52 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z19sm965973fam.16.2010.10.21.10.57.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 10:57:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010211513.06176.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159528>

Johan Herland wrote:

>   Allow combine_notes functions to request that a note be removed,
>   by setting the resulting note SHA1 to null_sha1 (0000000...).
> 
>   For consistency, also teach note_tree_insert() to skip insertion
>   of an empty note when there is no note to combine it with.

I guess it's probably also worth clarifying that the term "empty note"
means null_sha1 rather than empty_blob_sha1.

i.e. something like:

	For consistency, also teach note_tree_insert() to skip insertion
	of an empty note (a note with val_sha1 equal to null_sha1)
	when there is no note to combine it with.

The previous behavior iiuc would have been for write_notes_tree() to
write invalid trees after such an operation.
