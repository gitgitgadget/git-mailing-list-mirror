From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Pack v4 again..
Date: Mon, 16 Feb 2015 17:48:28 +0700
Message-ID: <CACsJy8AP88yX39QSyF2nN-01TN=7-0rKc==ncSua14_GM4s+Fg@mail.gmail.com>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
 <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr> <20150216064537.GF32381@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNJEf-0002ud-FR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 11:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbbBPKtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 05:49:00 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48819 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbbBPKs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 05:48:59 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so22742789igd.4
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AVBfkAuPJB6GlnW+ZbMOALeK/q53c6EfeM8PUqgnRBI=;
        b=hP09uUcsnMiLjR1XYPA1oDT5ALG61KC4tDJefj1z7LYlAuknbFt6dD1JEE7ECDSXxo
         CUNSy22xc9Ko+PvULpXF9X8mMHfZbpAuS19N65/t81qz1a8LJHiLADhRbmyrLl+9pYAi
         9pphqk+JBvkf1ULgWEEJlSAXHDY6d/H2yNv6IngZPutSAOlK78TjntITNHkErgjEOE6M
         Wq2CtB0DzlC3pH9Z3LQa2YHg3neihlGKF/EBzD+vTNrAeIYKabKEaFtLHVj7To0e13JF
         FSeQ4BQO5vIRUHIxaHnq1V+CTDK07YclxXMIXYXZKPOL2Xfuw+J4knEL+2/tGfMyl0vZ
         LHIA==
X-Received: by 10.43.19.134 with SMTP id qk6mr28596522icb.29.1424083738641;
 Mon, 16 Feb 2015 02:48:58 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 16 Feb 2015 02:48:28 -0800 (PST)
In-Reply-To: <20150216064537.GF32381@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263894>

On Mon, Feb 16, 2015 at 1:45 PM, Jeff King <peff@peff.net> wrote:
> Somewhat related to this, I was playing this weekend with the idea of
> generating fast tree diffs from our on-disk deltas. That is, given a
> base tree and a binary delta against it, could I reliably reproduce a
> diff (one way or the other) in O(size of diff), rather than O(size of
> tree)?

If you add a "delta" base cache for v4 trees to avoid the recursion
issue Nico mentioned, you effectively have a "diff" that aligns at
tree entry boundaries. The v4 tree encoding will become just another
delta format from this perspective. I'm very tempted to just go with
this to take advantage of v4 SHA-1 encoding, ident and path encoding..
-- 
Duy
