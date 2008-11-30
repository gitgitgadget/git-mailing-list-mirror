From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sun, 30 Nov 2008 17:29:08 +0700
Message-ID: <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
	 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
	 <20081128192033.GF23984@spearce.org>
	 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
	 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 11:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jZT-000808-2N
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYK3K3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 05:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYK3K3L
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:29:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:64423 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYK3K3K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:29:10 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1469083fgg.17
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GK0MvOTn7QCYTedJnvIO3eg0AjcxV1JQheETF7PW4kM=;
        b=ubv+fPIfeedRD7aUsRS1WrM2hedPILZTgrtl1G57fh5PwvO0OBCflTSputl8GE0GEB
         E3qDW0nAsw5VK+IDwBSB9fUO+rWofRmbIGyL3fY/Uqcf47pEHQRm5moPbxHiEwmPzAo8
         y7P5iRGmapqYovAgYN2P0LYa5tYykCiW+F8MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I7aXD3ky5BPoEVKit9VAl57ZCzkzDnFkxO1hodERC2VnLebuYV5g8dNKOwcUIZscm8
         GIcJiLnRkdttKXKx+ZbOMAMgbeopWNbqvjBgfEo2NrmFvZ+XZ08Od5WKuoZlYu659era
         /waU6fTJXmTUsME7ExWHq2SYsM7YU6YX3URgs=
Received: by 10.86.63.19 with SMTP id l19mr5895587fga.15.1228040948524;
        Sun, 30 Nov 2008 02:29:08 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Sun, 30 Nov 2008 02:29:08 -0800 (PST)
In-Reply-To: <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101960>

On 11/29/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 11/29/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  >  If there's any need for this to be distinguished from "assume unchanged",
>  >  I think it should be used with, not instead of, the CE_VALID bit; and it
>  >  could probably use some bit in the stat info section, since we don't need
>  >  stat info if we know by assumption that the entry is valid.
>
>
> Interesting. I'll think more about this.
>

As I said, CE_VALID implies all files are present. I could make
CE_NO_CHECKOUT to be used with CE_VALID, but I would need to check all
CE_VALID code path to make sure the behaviour remains if
CE_NO_CHECKOUT is absent. It's just more intrusive.

I have nothing against storing CE_NO_CHECKOUT in stat info except that
it seems inappropriate/hidden place to do. ce_flags is more obvious
choice. I haven't looked closely to stat info code in read-cache.c
though.
-- 
Duy
