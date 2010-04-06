From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 2/7 (v5)] basic api and porcelain
Date: Tue, 06 Apr 2010 20:25:57 +0100
Message-ID: <dbe35e7547614331d19b811c180731aa@212.159.54.234>
References: <4BBA40CD.5040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>, <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 21:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzEPZ-0001D6-Js
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 21:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab0DFT0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 15:26:04 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:46740 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab0DFT0B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 15:26:01 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id EAC6F819C76D;
	Tue,  6 Apr 2010 20:25:54 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 6FD5820C6C3;
	Tue,  6 Apr 2010 20:25:59 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Zr5qoZ5JFlsV; Tue,  6 Apr 2010 20:25:59 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id A1D87105040;
	Tue,  6 Apr 2010 20:25:57 +0100 (BST)
In-Reply-To: <4BBA40CD.5040301@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144166>

On Mon, 05 Apr 2010 20:58:05 +0100, Nick Edelen <sirnot@gmail.com> wrote:
> +	/* initialize header */
> +	strcpy(head.signature, "REVCACHE");

head.signature is 8 characters (see below), and so is "REVCACHE".  Surely
either
head.signature needs to be 9 characters, or you shouldn't use strcpy. 
Indeed, mostly you do seem to be using memcpy ...

This is in a couple of other places too, with both rc_index_header, and
rc_slice_header.

> +/* single index maps objects to cache files */
> +struct rc_index_header {
> +	char signature[8]; /* REVINDEX */
> +	unsigned char version;
> +	uint32_t ofs_objects;
> +
> +	uint32_t object_nr;
> +	unsigned char cache_nr;
> +
> +	uint32_t max_date;
> +};

> +/* structure for actual cache file */
> +struct rc_slice_header {
> +	char signature[8]; /* REVCACHE */
> +	unsigned char version;
> +	uint32_t ofs_objects;
> +
> +	uint32_t object_nr;
> +	uint16_t path_nr;
> +	uint32_t size;
> +
> +	unsigned char sha1[20];
> +};

-- 
Julian
