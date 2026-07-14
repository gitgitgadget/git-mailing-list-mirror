Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D53769F8
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996954; cv=none; b=ktoxqQwj1J4DC7GYHPTuBOSXNJ5XUAoZCa9M6kp7BSnjD0xNRfxhQF1IBxCevyqN0pG0eXVTeAo7LiWdDZQcuKjJDEGBA7H0sNKam/NXPIgkBy2YDu46Zdi9aSC4LSv7uRydlwJ9fjj7Z8JY6pV5Ummv1vZlLETFNTVbMgJVYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996954; c=relaxed/simple;
	bh=7aX49kACbrcM/q+bMsWdS9bMAhGluT0TwI9w5+HBxIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY6mBAOSejTW3jI+ASEnS9/LmkX7W5ukH8befIkUaGeFho53fMvs0VkZmuOpmONkmYGTiKPx08RwgPXecKaAUJmbSmjVzUCk5nsv4oNg70DnEnp+q7oqhZEorW/kKtmdLrT0ARM8+p7zaCuai/gbyGy0QGO91latIeaVK/c79Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fF71weR9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fF71weR9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efef6533aaso5547186d6.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 19:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783996952; x=1784601752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rRX6OkIZWTvAuWI5tSKBJ4spaHVb5GGrzBYfQivCYE8=;
        b=fF71weR9zCLRMzcXteA19kJXsoJ0Kk324D3XNdxWhhrmDTSsHt2jHDAKLaJUtii58q
         LKfodGSDk5B9U1Pr/C99y4X2+4mvW4SPqYYP9cUzvp/nL6QX8p5XYs2buMMy57A5P7cO
         4AD/9/zW2iSNp0MtbkscyIaMdwd3TWCSOJ/NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996952; x=1784601752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRX6OkIZWTvAuWI5tSKBJ4spaHVb5GGrzBYfQivCYE8=;
        b=Mswg3MUYnDaDd9tL1fJv9LJi1B57Llh4c6HCkByUNfCo3NaOO7Tu5kv2nZFlmSe2tf
         6rjUTzcS1ganWHxYg6AiGxjkbSTHxiTpnEi6brWokGmn26GTTMP2uhRW1/Kr+DYru/r/
         nbOzj6p8SSBzxGXHIzf4kUb6WBGyyHLuY0caLutwfq5SriX7ghGgAdiqjmMKaazwS+GO
         60oy6cOCfXXTP015pt6+iCCBxKC6aaQEM2x1xtYpErBHM9HBtzw9LGQf/CuY+l5ibPs+
         /UsdBkVqQny3+ggAW0wn+FUt/FGSvWru5u9jTHFcIB2fgL3HIQfAo85Lyff+rKf0mnaQ
         tPIA==
X-Forwarded-Encrypted: i=1; AHgh+RpkNQNcduNL2OxhkLiQwdZlItqt5rgObCusVmsTDH/9kkhg0BtD5pME2o8CVQ8HYTydDSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+4OhHHM/4ciTDZeFxpa7SQPn+hj512JgQRHr605MZNt3WQIW
	EcOr6xWT2MIfcyn+cKct/TFah7+eALG3RMsaoGXmBX5LTKCbPezIO4CBxidoZ6Ngg4w=
X-Gm-Gg: AfdE7cnl2rPHxxhJiod/OguUPnsEFePv9+/5hxfIak0PJD4shoE850rXmlpHK8Wtoej
	Gkq9KJ+sbm06AVdacyI45hSnokkxPeWULfggFA8rqq6dGU7cA+Orf9JR+iCza+sfOHK/XCTtvu7
	EpeIrjpvi5JA8L701lobZz0kScdKnjDfDqcYX4ErKqUDykWyO/3RPHrYch8YUnkAdhEVeBCaHou
	QgiQJEwZBP3HWkgeh4Ysxgk3BJZsw7AuuGmLWwQ/ynU7XEsy+m/cShJpxpcyMuaZ21JDWSsvO8M
	BcaBnQSJAceZB0xw5XHSKhJUy/CfrNlNBPk8cZiEA5YPCLYIAeIxRFkfVcaVJ810ujkxUDr0tpa
	lIx+J/KPU/8qz5y3XXE1qrwMIxTAqDzI2y5HEt5NweBWjMW0XQ4Qxd41SVHY0tU4WODLCHhUUKj
	ZjRxbt6+4Zp9UeGMVLvJJxCaYr
X-Received: by 2002:a05:6214:4882:b0:8fd:6df3:b377 with SMTP id 6a1803df08f44-90402a6a709mr133050736d6.59.1783996951974;
        Mon, 13 Jul 2026 19:42:31 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-904116650b7sm122347966d6.8.2026.07.13.19.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:42:31 -0700 (PDT)
Date: Mon, 13 Jul 2026 19:42:25 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <alWiEXbP5vOcCJ7F@com-79390>
References: <alVn7UWvdWRAG-Vv@com-76773>
 <xmqq4ii2wlo1.fsf@gitster.g>
 <alVs4JO9BNQrXsnO@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alVs4JO9BNQrXsnO@com-76773>

On Mon, Jul 13, 2026 at 03:55:28PM -0700, Ted Nyman wrote:
> > And "b4 am" seems to be having problem grabbing the patchset X-<.
>
> Sorry for the noise -- Mutt rewrote the original cover-letter
> Message-ID. The patches reference the corrected cover:
>
>   https://lore.kernel.org/git/cover.1783982021.git.tnyman@openai.com/
>
> I confirmed that this retrieves both patches:
>
>   b4 am cover.1783982021.git.tnyman@openai.com

This is a mistake on my end as I was porting over some of the scripts
for sending patches to the mailing list to OpenAI's infrastructure.

The short version of this e-mail is that the issue is fixed. But the
longer version is funny (at least to me), so I figured I would share.

As some background, my workflow for sending patches to the mailing list
is to use a script called 'git mail' that effectively runs format-patch
to build an *.mbox and then opens Mutt in that directory. I then review
the patches one last time before sending, and then run a macro I have
bound to 'B', which (effectively) runs <resend-message>.

For reasons that I cannot quite recall, I chose this workflow many years
ago when it would likely have been more appropriate to use `mutt -H`,
which does *not* rewrite Message-ID headers when resending.

To work around this, I wrote a patch that I applied to the version of
Mutt I used both on my old work laptop as well as the Linux workstation
where I did the majority of my work. The patch is fairly small, and is
effectively:

--- 8< ---
diff --git a/postpone.c b/postpone.c
index f557976d..accbb4f6 100644
--- a/postpone.c
+++ b/postpone.c
@@ -607,13 +607,9 @@ int mutt_prepare_template (FILE *fp, CONTEXT *ctx, HEADER *newhdr, HEADER *hdr,
   newhdr->content->length = hdr->content->length;
   mutt_parse_part (fp, newhdr->content);

-  /* If resending a message, don't keep message_id or mail_followup_to.
-   * Otherwise, we are resuming a postponed message, and want to keep those
-   * headers if they exist.
-   */
+  /* If resending a message, don't keep mail_followup_to. */
   if (resend)
   {
-    FREE (&newhdr->env->message_id);
     FREE (&newhdr->env->mail_followup_to);
   }

--
2.26.0.106.g9fadedd637
--- >8 ---

(The Git version this patch was prepared with should give you some sense
of how ancient this part of my workflow is ;-).)

When looking at this yesterday after sending the 'no-ref-delta' patches
to the list, I could not figure out quite why my Mutt client was
rewriting Message-ID headers until I remembered the aforementioned
patch.

The fix is somewhat OpenAI-specific, and so not interesting to share
with the list, but effectively relies on piping messages to 'mutt -H -'
to send the message without dropping (and thus rewriting) the Message-ID
header.

(As an alternative, I could have continued to carry that patch to
'postpone.c', but in retrospect it seems gross^W unnecessary, so I
ditched it.)

Thanks,
Taylor
