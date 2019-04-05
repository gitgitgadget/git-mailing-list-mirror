Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBEB20248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDEUS1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:18:27 -0400
Received: from mout.web.de ([217.72.192.78]:39453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfDEUS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554495502;
        bh=AAF+cfuA6m0CSCVj7GLRmZ3ngBG7bb2h+2KnbEGTPbk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SF84vgKS3LuPcEhjFiyDUot2rRHUjo5hYAZ8eXTqz5tcH1LEE66VKS3Qvax/PDQ3x
         dGSjvKF9vfGEa4OztsvVX2niY4KMUgPQCYjf7lCRT0+TLXoqXCoD6S0DswvyJl1hts
         KcAzbqDbPFBgG5a/NuiD8vnYp5gkB4zt+iJMN8HA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([79.203.21.163]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecNe-1gZGXA1kfW-00qTjJ; Fri, 05
 Apr 2019 22:18:22 +0200
Subject: Re: [PATCH v2 05/13] midx: check both pack and index names for
 containment
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190405180306.GA21113@sigill.intra.peff.net>
 <20190405180604.GE32243@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8f188559-c1a9-7717-4b2c-a7397cfaa6bc@web.de>
Date:   Fri, 5 Apr 2019 22:18:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405180604.GE32243@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hup+dGHsiuDnsngR4hPp2VvmSApDhauMmCDqrNyYKBQK7nwiOoG
 tGWSVuIYgpuwa4n6117PKmL8l+49kHuYge78mWcQ2o8lZlz+9LUXUJeZaJcW0qBs6eZdML4
 cgwssq52A6fWHCb/hWZ97K7iIPZnebYwnyQOAz7SnhB8dqTCvZtWaPdozrLRRmPZpIn3QwG
 iVzAODVAt3jMKfS3wIWzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+wh4tYwX/uc=:VQMLkvMyJxdQPEdyWEIp0o
 j3ZiQG8DLUkdR9Az78JSTczAqTbDhNALJr0JUBmJ9z6hqUGAPtGh+390XgnMPNGtBXnBBKLN/
 I0vn7+Pek9kXLleaeRCVQvlC9AVV7YrqYUBV5k4X4NQCLgvgtFsfWegusr6XYb12WE6sAMAd2
 RUex0E+OHj0qC7zeJYS6QWKNNGAxWObkRtkozf/5+7LabUkm874vJ3sspdiHeeZ4GTEwi8OXI
 mi60W81tAY0C5QWq+4qTHY4tcobtrJJUlY1oH9SqY/EedOc5MZjPEckK3zsaN/BwCde4yBifv
 6i99+OZ2TtXqRg2+ztt2mZBg2N0tPHAJnX9lKOIlnldyE6DAetojB0ckQz1RbJVVmjxcQhF5E
 xgB3ABUlTBBlYdHM1eI3i67RJf21sxDosGmAYtnhk/vq9+1O7DM7DxGfT5aHagYgJUhTLyETc
 kul9uhNH0x9xbuUSmitLyH1ZFNYvcjwAg8Xc1aBlQATWk610RdvsRf+C5lcwK6F8c9He7OQ+D
 5vpFfuY9KvVc1zP9Fy/4AIhq+SJYM/+vR7+XnN1oCi/uWowo5kjh9pfgjfP7wfY6wU9QXgZBi
 3d4X1MwBX9VcSTBGreyNsqOPR1haQ7Mo18GYwoOpdu+66GWQPStGnki7gEF1ErELwFbuEOcvV
 yr+voPh1jxpdYkDqiDSAEPGkoeK91ycppuGzcUzLXhdSfrRqYhAxoN/aginJ+Z58q3j+SvlzE
 Om0LI5ZlLoOtXmXcd/Tnb+/7+5jYtDX8YJoue5rArVLTOGbzHWac3yJwo3IPNFeCfNYyqzdRq
 jrF8XoW91tlgxLYYlVWVzjMxsMH0mUyTTORYX8hHLoKPl3sGahaIQfJFWjM+cHyZRfJb20Huu
 P+L/J3U++s5VHCQrTT9c9Zr+rmPufCJ29/pRMla+h+/o9GxW1er+fz5MzN4OdT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2019 um 20:06 schrieb Jeff King:
> A midx file (and the struct we parse from it) contains a list of all of
> the covered packfiles, mentioned by their ".idx" names (e.g.,
> "pack-1234.idx", etc). And thus calls to midx_contains_pack() expect
> callers to provide the idx name.
>
> This works for most of the calls, but the one in open_packed_git_1()
> tries to feed a packed_git->pack_name, which is the ".pack" name,
> meaning we'll never find a match (even if the pack is covered by the
> midx).
>
> We can fix this by converting the ".pack" to ".idx" in the caller.
> However, that requires allocating a new string. Instead, let's make
> midx_contains_pack() a bit friendlier, and allow it take _either_ the
> .pack or .idx variant.
>
> All cleverness in the matching code is credited to Ren=C3=A9. Bugs are m=
ine.

I didn't consider it to be particularly tricky -- but then kept the dots
in both filename extension strings, which is not going to fly, as they
are skipped by the common-prefix loop..  Thanks for fixing that.

> There's no test here, because while this does fix _a_ bug, it's masked
> by another bug in that same caller. That will be covered (with a test)
> in the next patch.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was tempted to suggest that the midx struct just store the base name
> without ".idx" at all, but having callers pass that is no less tricky
> than passing ".idx" (they still have to allocate a new string).

The middle part of the comparison function would become:

	if (!*idx_name && (!strcmp(idx_or_pack_name, ".idx") ||
			   !strcmp(idx_or_pack_name, ".pack"))
		return 0;

No allocations needed -- except when building the list.

(And this time we'd actually need the dots.)

>
>  midx.c | 36 ++++++++++++++++++++++++++++++++++--
>  midx.h |  2 +-
>  2 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 8a505fd423..0ceca1938f 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -307,7 +307,39 @@ int fill_midx_entry(const struct object_id *oid, st=
ruct pack_entry *e, struct mu
>  	return nth_midxed_pack_entry(m, e, pos);
>  }
>
> -int midx_contains_pack(struct multi_pack_index *m, const char *idx_name=
)
> +/* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
> +static int cmp_idx_or_pack_name(const char *idx_or_pack_name,
> +				const char *idx_name)
> +{
> +	/* Skip past any initial matching prefix. */
> +	while (*idx_name && *idx_name =3D=3D *idx_or_pack_name) {
> +		idx_name++;
> +		idx_or_pack_name++;
> +	}
> +
> +	/*
> +	 * If we didn't match completely, we may have matched "pack-1234." and
> +	 * be left with "idx" and "pack" respectively, which is also OK. We do
> +	 * not have to check for "idx" and "idx", because that would have been
> +	 * a complete match (and in that case these strcmps will be false, but
> +	 * we'll correctly return 0 from the final strcmp() below.
> +	 *
> +	 * Technically this matches "fooidx" and "foopack", but we'd never hav=
e
> +	 * such names in the first place.
> +	 */
> +	if (!strcmp(idx_name, "idx") && !strcmp(idx_or_pack_name, "pack"))
> +		return 0;

This is asymmetric, and thus the function should not be used for sorting,
where it would be called for random pairs of values. For the binary search
it's fine, assuming the list contains only index filenames (ending with
".idx"), as the search string is always passed in as idx_or_pack_name.

And an extension-insensitive lookup works fine in a strcmp()-sorted list
because the order wouldn't change when sorting it again with a looser
stable extension-sensitive sort.

> +
> +	/*
> +	 * This not only checks for a complete match, but also orders based on
> +	 * the first non-identical character, which means our ordering will
> +	 * match a raw strcmp(). That makes it OK to use this to binary search
> +	 * a naively-sorted list.
> +	 */
> +	return strcmp(idx_or_pack_name, idx_name);

At this point we could also compare the chars like this:

	return (unsigned char)(*idx_or_pack_name) - (unsigned char)(*idx_name);

This avoids a function call, but doesn't look very pretty.  And I'm not
fully sure the casts are correct.

> +}
> +
> +int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_p=
ack_name)
>  {
>  	uint32_t first =3D 0, last =3D m->num_packs;
>
> @@ -317,7 +349,7 @@ int midx_contains_pack(struct multi_pack_index *m, c=
onst char *idx_name)
>  		int cmp;
>
>  		current =3D m->pack_names[mid];
> -		cmp =3D strcmp(idx_name, current);
> +		cmp =3D cmp_idx_or_pack_name(idx_or_pack_name, current);
>  		if (!cmp)
>  			return 1;
>  		if (cmp > 0) {
> diff --git a/midx.h b/midx.h
> index 774f652530..26dd042d63 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -43,7 +43,7 @@ struct object_id *nth_midxed_object_oid(struct object_=
id *oid,
>  					struct multi_pack_index *m,
>  					uint32_t n);
>  int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, =
struct multi_pack_index *m);
> -int midx_contains_pack(struct multi_pack_index *m, const char *idx_name=
);
> +int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_p=
ack_name);
>  int prepare_multi_pack_index_one(struct repository *r, const char *obje=
ct_dir, int local);
>
>  int write_midx_file(const char *object_dir);
>

