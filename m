From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Sun, 30 Dec 2007 20:12:02 +0100
Message-ID: <e5bfff550712301112w4f5db2e1x86d25be52373f641@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550712301106l133dd38btd2cc4be02159387d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 20:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J93aL-0003HL-D4
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 20:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbXL3TMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 14:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbXL3TMH
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 14:12:07 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:17791 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbXL3TMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 14:12:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4277154rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=79MQVPNtMZfX65J4vRbwf7890JNJ5nyvL6XqCL+RhGY=;
        b=Gx6C7X7A+O76nyp+Cv5Jy4PGMc3Oy7f8iOQ4SaucYL2EtCH/Odh7M9ESNFr0U8i+/BnwIbsKXThwvqJzSXzIvniP+0rlm5hegHdbmTeBUSkI8ExZCmR6j4C1ExI9DnZuc/xztavMSWx2t+mJHQDYIj8Dq42YKRZSINmWvnZDCDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oOdkEAZ6ePj0gYJYbaKFEAnQk5HxjO/cWCHvmfx8yIEM53S3b0eBdWP+7YY7mFM5rVAkjgFhcS22edf+Wtfxu9yybqlA3gRUPmPZDILMstW5GhDmTrvzEsmJdhFKethq9/RDXb4YDALc60ZL2y5ou376rlIMUwf/pHdpwy4DH8o=
Received: by 10.141.172.6 with SMTP id z6mr5970667rvo.54.1199041922960;
        Sun, 30 Dec 2007 11:12:02 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 11:12:02 -0800 (PST)
In-Reply-To: <e5bfff550712301106l133dd38btd2cc4be02159387d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69377>

On Dec 30, 2007 8:06 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> In particular
>
> st = inflate(&stream, Z_FINISH);
>
> called from unpack_compressed_entry() in sha1_file.c accounts for 72%
> of total time.
>

That's the snapshot:

http://digilander.libero.it/mcostalba/callgrind_git_log2.png
