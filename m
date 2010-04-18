From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 11/11] http-fetch: Use temporary files for pack-*.idx
 until verified
Date: Sun, 18 Apr 2010 11:57:44 +0800
Message-ID: <20100418115744.0000238b@unknown>
References: <20100416100307.0000423f@unknown>
	<1271534864-31944-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 05:58:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Ldy-00039z-6F
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 05:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab0DRD55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 23:57:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45412 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0DRD54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 23:57:56 -0400
Received: by gwaa18 with SMTP id a18so2057621gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mVR0UPVJRGK/ajn0MmICHIIxfBCml865IFoiJt7DWrY=;
        b=XAV0difuRaQ2j4BluoSXWlysaRlnOyn46oQaFLZlRiJPRhU+WfEhpig5kSs9iLAqFC
         kOTO106yKekwsL36yIbL/k1xjHzh4eVdW34JWxUxymIx4QSKJ43s/s3wETQJfugZ+jfL
         xqYpBUI0Rtho+e2CltEnRFTc3NIAjEW4E1Gb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ToMC/Yoi/oMS44o+rWjmBmZXeB7O0hJsP5ZbNpWye6codKEjIvwjr0w5cerVR96fX9
         4m5/0gUAl7w8+x87ZrcGbg+mhGAklmslIDoBqrluudheFCfRRtqUBR32fL126W+8M9BW
         tcDmTAmAOhgblXDrmjLACo8QyKkZZ96ZKxUJI=
Received: by 10.101.29.7 with SMTP id g7mr1248371anj.1.1271563074957;
        Sat, 17 Apr 2010 20:57:54 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id d39sm30560528anp.0.2010.04.17.20.57.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 20:57:54 -0700 (PDT)
In-Reply-To: <1271534864-31944-11-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145209>

Hi,

On Sat, 17 Apr 2010 13:07:44 -0700
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> Verify that a downloaded pack-*.idx file is consistent and valid
> as an index file before we rename it into its final destination.
> This prevents a corrupt index file from later being treated as a
> usable file, confusing readers.

Perhaps this should be added in:

  Check that we do not have the pack index file before invoking
  fetch_and_setup_pack_index(); that way, we can do without the
  has_pack_index() check in fetch_and_setup_pack_index().

The above was referring to this hunk:

> diff --git a/http.c b/http.c
[snip]
> -	if (has_pack_index(sha1)) {
> -		ret = 0;
> -		goto cleanup;
> -	}
> -

-- 
Cheers,
Ray Chuan
