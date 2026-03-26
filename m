Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296637C10C
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541708; cv=none; b=At9AOM8YSp1wuXdkGTkbOi32H9uKuWt0f2SCX7nFBwHr7CrMIgmmeipzur1oLZQb9++a5o/79hBjXEVknLjUSsVMwtN22Jmj3vbeDStdZinjmSjWNZHbwH4RZ5YbQbsq/AOIptA8wOqge9dXK6gJaa07GGyYx3q/ui9Gewdkyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541708; c=relaxed/simple;
	bh=kaSmF5ceL32cEpDJlqoeDR0fSWbHW59EzwMvy+iLYoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv/5HBIPjqb0BxhcpSkDMONjlvaU4KLT/FexWORGDBuBb9Uh7V9tvrMN3yJrnZ6m9IIAR8l57kvKMWQEQYgt5rP9bEd/+S+IKnmG65e0Nc2U9Y3r1UaAgh6Kn6bxwFgyh27+EqVDp86Z9l+k4dGU4k9tHXq6c9Y3kK9To8ZhMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJdaidR9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJdaidR9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso556780f8f.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541706; x=1775146506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRXiTKpnbAANon70XUdRVn2lj1+Qgrv7PsFB12OFu1w=;
        b=DJdaidR9SwoH8Q+k9mnzm+MAiGd/ZC2tJrIY6hd7BrrvD85WHRjJ1jAxcyW9S0iWr3
         9zyxSCJ0r1NE6xNcAKIbJnXaK5RLhuTGt7d1yvLoS9zWPJvLc0OC7U7bzZiuw/U7C7s+
         1Sqz8yeQgl6vJhqvqeKvSEND8nXyogQG60hZFCyfPwNkGBBcQ9W3+cX6zXKqubQUPNlg
         CSRaQTS1X/P8oKOC5HwTcgLF1kKCUICHHLzQEI9FkKucEV1SuHAEShpa+JoM1jhW5ZSQ
         6jbFVhvWZwtOTQE3ESA3WNOnxyH2I5/wdAVKHy02gj9MNLS9DgPzplS2bAoS5bJKNs7o
         j9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541706; x=1775146506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRXiTKpnbAANon70XUdRVn2lj1+Qgrv7PsFB12OFu1w=;
        b=gc1fCd8UUZGuun456hfwMM954dStrvwIFFxUKgsl0I3usHMt84cJZR/2VTfBxI+W6l
         T69ROH1n1ni8Cs3ffg44K+yFMZepzVhay98Ui6a1cEr51XFLOpUv8d5dk9T8wOpROG4d
         2wtSyy9I0b7dU/bel3Rfg9mnI5plw8VeJwalJRCzAsqTPekPGH7TwIYPfGzcNsgxXc7E
         8En+iBoS1soCN8IoxVUDICniqbiq7sx1EmxHL7UoBf2yQvDzDhkHk4jaUMlwyPE710E0
         fL30v1DORwP5rCAA+s7Encw1q7zKb2mAvdBKxA6P2WW1/KpjpXUmsra3RVxp/YfyqEB4
         1BYQ==
X-Gm-Message-State: AOJu0YwO0bnKSYp/egzxi+zTolb/wtutXHA0AoWt/27Bl7j0EX4bS7Qw
	eFHPBl4Xu2F0mYYmiM+CsXIvNhVz1CEnv/NgxEQZWKMdx/xoDt4NWNUe
X-Gm-Gg: ATEYQzyppsKYg4vjaBNT8RZ6HWIk1PN8l8103EGfX5Uv4iwALmve9OroChkGd9hcAp0
	wI+NHJSOF2Y06F6VoEXjmuBFETu+uDxLKp4/Wk4brRlTCSoCC7O3uWy6zqUgbTwHHw4dAWL1OJT
	dzwj3KDhMSjRyR54OV2YULzuVrUElyMOnxn+9AfdJRg2bPCHUiPIknd6H4VVCFSoWr9e0xN3Uw4
	FvHsxSPp7tcstJlTx4966qirTiRbFfTmPMqfyL6VeB1mZjnGmRWYHWY/Lzfu9Yj7n1Tndht7bTx
	ThPQPEMEVRRFyp1oIebWPyyRbUGOtZlsuyR89A5bQcXvquqdx7hvFKuiU/15trox5Yhyeprdw3l
	J4rkHoBuNEVnZPQILdHa5YrpirVLhr4xvIMlawkXiefcV8tgkbxHbbT66Re2YKNdwwVVyTNZBus
	P65lzXpI28iKihv2WXyoaGEUwe/3P7a91h
X-Received: by 2002:a05:6000:2512:b0:43b:45a0:9df6 with SMTP id ffacd0b85a97d-43b88a0ffb5mr12800960f8f.32.1774541705398;
        Thu, 26 Mar 2026 09:15:05 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e35esm8350709f8f.6.2026.03.26.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:15:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:15:02 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [GSoC PATCH v2 2/4] pack-write: add helper to fill promisor file
 after repack
Message-ID: <acVbhqGEc2826Cii@lorenzo-VM>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <CAPig+cR7-3rdkHvGbzk8O7P=83pxBTvqXTUgMxYpf+OK9jNCgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR7-3rdkHvGbzk8O7P=83pxBTvqXTUgMxYpf+OK9jNCgg@mail.gmail.com>

On Mon, Mar 23, 2026 at 04:27:44PM -0400, Eric Sunshine wrote:
> On Sun, Mar 22, 2026 at 3:18 PM LorenzoPegorari
> <lorenzo.pegorari2002@gmail.com> wrote:
> > Create a `copy_all_promisor_files()` helper function used to copy the
> > contents of all ".promisor" files in a `repository` inside another
> > ".promisor" file.
> >
> > This function can be used to preserve the contents of all ".promisor"
> > files inside a new ".promisor" file, for example when a repack happens.
> >
> > This function is written in such a way so that it will read all the
> > ".promisor" files inside the given `repository` line by line, and copy
> > only the lines that are not already present in the destination file. This
> > is done to avoid copying the same lines multiple times that may come from
> > multiple (redundant) packfiles. There might be another better/cleaner way
> > to achieve this.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> 
> Thanks, I think this version addresses all my review comments[*] and
> looks much better overall. Use of `strset` makes a big difference over
> the previous attempt. A couple minor comments below...
> 
> [*]: https://lore.kernel.org/git/CAPig+cQSsMfvHJnwuXGQ1Je8ekz=Rqbaibn-3shbya5y-5xTKg@mail.gmail.com/
> 
> > diff --git a/pack-write.c b/pack-write.c
> > @@ -621,3 +622,63 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
> > +void copy_all_promisor_files(struct repository *repo, const char *promisor_name)
> > +{
> > +       struct strset dest_content = STRSET_INIT;
> > +       struct strbuf read_line = STRBUF_INIT;
> > +       struct strbuf promisor_source_name = STRBUF_INIT;
> > +       struct strbuf write_dest = STRBUF_INIT;
> > +       FILE *dest, *source;
> > +       struct packed_git *p;
> > +       int err;
> 
> Nit: I probably would have declared `FILE *dest` within the scope of
> the repo_for_each_pack() loop as suggested in the review, but it's not
> worth a reroll.

Ack. I will fix it. Thanks!

> > +       dest = xfopen(promisor_name, "r+");
> > +       while (strbuf_getline(&read_line, dest) != EOF)
> > +               strset_add(&dest_content, read_line.buf);
> > +
> > +       repo_for_each_pack(repo, p) {
> > +               if (!p->pack_promisor)
> > +                       continue;
> > +
> > +               strbuf_reset(&promisor_source_name);
> > +               strbuf_addstr(&promisor_source_name, p->pack_name);
> > +               strbuf_strip_suffix(&promisor_source_name, ".pack");
> > +               strbuf_addstr(&promisor_source_name, ".promisor");
> > +               source = xfopen(promisor_source_name.buf, "r");
> > +
> > +               /*
> > +                * For each line of the promisor source file, check if it already
> > +                * is in the promisor dest file. If not, add it to write_dest, so
> > +                * that it will be written in the dest file.
> > +                */
> > +               while (strbuf_getline(&read_line, source) != EOF) {
> > +                       if (strset_add(&dest_content, read_line.buf)) {
> > +                               strbuf_addbuf(&write_dest, &read_line);
> > +                               strbuf_addstr(&write_dest, "\n");
> 
> Not worth a reroll, but this could also be:
> 
>     strbuf_addch(&write_dest, '\n');

Ack.

> > +                       }
> > +               }
> > +
> > +               err = ferror(source);
> > +               err |= fclose(source);
> > +               if (err)
> > +                       die(_("could not read '%s' promisor file"), promisor_source_name.buf);
> > +       }
> > +
> > +       if (write_dest.len) {
> > +               strbuf_strip_suffix(&write_dest, "\n");
> > +               if (fseek(dest, 0L, SEEK_END))
> > +                       die_errno(_("fseek failed"));
> > +               fprintf(dest, "%s\n", write_dest.buf);
> > +       }
> 
> Can you explain why you strip "\n" and then re-add it via fprintf()?
> The reason is not immediately obvious.

Stripping it and then adding it again is actually not necessary. I think
it was necessary in a previous iteration. Thanks for noticing, will fix!

> > +       err = ferror(dest);
> > +       err |= fclose(dest);
> > +       if (err)
> > +               die(_("could not write '%s' promisor file"), promisor_name);
> > +
> > +       strbuf_release(&read_line);
> > +       strbuf_release(&promisor_source_name);
> > +       strbuf_release(&write_dest);
> > +       strset_clear(&dest_content);
> > +}
> 
> Everything appears to be released. Good.

Thank you so much for your help Eric,

Lorenzo

