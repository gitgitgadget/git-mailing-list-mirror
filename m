Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07776C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 10:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiHIKrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHIKrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 06:47:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90886120A3
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660042024;
        bh=gAIKPrIW9PT3TPFtlH5W/xTEqu0DD/ElOvPb6K6hwII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TNOfBWsBpCx6Q4Pr7/whUcmCTLrChVLJ/5cA5ujD8wLv2a3+MHsJp6zWSZjN+rxEs
         YOe5Vw9XTFEmHc11WRjHX4+lR98Ok9OM/6T6RRftcI5qY2lpAg3ELeaVg1lQHHnp/e
         xUcTG5YfUVrCN1HAI3/b2uX6IRaeYROeWfd6GNSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1oLuzm0iM2-001lRy; Tue, 09
 Aug 2022 12:47:04 +0200
Date:   Tue, 9 Aug 2022 12:47:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
In-Reply-To: <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
Message-ID: <9239s8np-69ss-n035-53s9-869s42p9srno@tzk.qr>
References: <cover.1659291025.git.matheus.bernardino@usp.br> <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kb3AvPgUhSuUPWH0THtWphgdKVDr/Nz1asHXDqpaW9kYWmIFTTf
 Jo1Ag/s6I9wUQBSacdHDKV8XuTNeyHjCTdiVJ9Zxjs0pJK1p3eSv7B1WVCuZ5V4dZ1xOl4c
 NDxWuGodCfc/Lwt/vVgL64zzEUh7z5C7iUyLXyI2QRi7ZvrLbNWwaNw7ROoPQIDhuw8dvNY
 nXEtZUjeoPt2MUXmsh6Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N6LZiu+NkrM=:PD5AlL/rXXkBW+UWfqhnyo
 bkEx5evQLGIWXnd7BSa/LS/GABuqld/0AdLapwu2vAeMLbV8/S7lMQG2XEwJwMhi8JtXx8Ekr
 SRC7Gnoe8WMwDehheg+288aU/BsXMEUQhqQPbqTQ5l8Pjs1CZRFxExizyt5Fb0kLOWHwMJAur
 3SGiRt2OJ7qdAvpHUj97aiSR408zCo6uMmkEg7a6f11s6175HkLBMMQL/ny/xgO8Usu2R0P/n
 8NLRkMeYIIvr2Hfe6hdLwupwocNS7hb3U4lRr1YhhuPNhQ6C4ydFDrNHzsUa//OoX04As3Vh3
 4gPnIyIqSBopdNKViIG6QposXcIbkv4WvivgWenn3wWfS9wPdv6lyR+r2O8/4aYGTkoiqc3Qh
 is3sB2Ck/f1EUxGekD/fBBgD4ddDr2KcCAdzH/6tOAyHArVJkGWm8zE5TSEaxfzH+qQJLwpgm
 oEoi3WNkqXIfg6GSfcgBlgUIU5fVoj0rBHK35nZb/uxBlS7KR0ErpfLd2JnF9QeBW1a5j0TAM
 Caz7i+zB1EI4VSqqw3T30fUGIo7/zn1EPrfM3aZLIo5z16/xWe+gWW9mD0HLg8QoqXlN/87Eh
 Lk12N7EasamJDtpRDO52GVmN8yoTZjlV0BIqFSYXDP47zuksfgiTORclmz7Tuv/duU9liS+yl
 JVNE/BKFzrpyQof6et07SkV6Iai5sewOITkxYrQ2pBBlTFzrgaYvhoUNRorq4hFqU+O6vsuyY
 wiUNHSmPQipCvo5LfNiui8iDTANEeEWbvLCAVVzTTkMW2fQAUTfiyKk5OnIRj0aB0gRG3EXIN
 uHeBCfYn8m0QZerSznVQZdgFuh/Dbbpswwfhz97dpSpig/lOiFDyREVuvx8j3zovBNF6cbuw+
 8rivtEbgxw2bBTV9jmUQKAZAY0sFLDZcT/yFIfF20NqI6QW22T+049JYnTOs5fjJIQlHu1Vqm
 96iBhVYWcdxOfqmo3k+c6qtV3mx8zwO7W856qmMK6Uf2iWgaFmvRllHhxdXEwErS0HnRV9mGO
 aS1YTyPW1aP/NHEnxUAkIRlcq7D/a4rpdSSDlbcIDhSG0msb0pD5Vy3TKDzT2m7wpCGNmqNyM
 n57R/iEIycGgMEYvX/L+1vgARSEi/4snH39GQPSfI71GqNeOH+fmmDcug==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sun, 31 Jul 2022, Matheus Tavares wrote:

> diff --git a/pkt-line.c b/pkt-line.c
> index 8e43c2def4..ce4e73b683 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -309,7 +309,8 @@ int write_packetized_from_fd_no_flush(int fd_in, int=
 fd_out)
>  	return err;
>  }
>
> -int write_packetized_from_buf_no_flush(const char *src_in, size_t len, =
int fd_out)
> +int write_packetized_from_buf_no_flush_count(const char *src_in, size_t=
 len,
> +					     int fd_out, int *packet_counter)
>  {
>  	int err =3D 0;
>  	size_t bytes_written =3D 0;
> @@ -324,6 +325,8 @@ int write_packetized_from_buf_no_flush(const char *s=
rc_in, size_t len, int fd_ou
>  			break;
>  		err =3D packet_write_gently(fd_out, src_in + bytes_written, bytes_to_=
write);
>  		bytes_written +=3D bytes_to_write;
> +		if (packet_counter)
> +			(*packet_counter)++;

The only reason why we do this here is to try to imitate the Perl script
that prints out a dot for every packet written, right?

But the Perl script wrote out those dots immediately and individually, not
in one go after writing all the packets.

Unless the tests rely on the dots in the output, I would therefore
recommend to simply scrap this functionality (and to write about it in the
commit message, with the rationale that it does not fit into the current C
code's paradigms and would require intrusive changes of questionable
benefit) and avoid touching `pkt-line.[ch]` altogether.

> [...]
> diff --git a/pkt-line.h b/pkt-line.h
> [...]
> +static void packet_initialize(void)
> +{
> +	int size;
> +	char *pkt_buf =3D packet_read_line(0, &size);
> +
> +	if (!pkt_buf || strncmp(pkt_buf, "git-filter-client", size))
> +		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
> +
> +	pkt_buf =3D packet_read_line(0, &size);
> +	if (!pkt_buf || strncmp(pkt_buf, "version=3D2", size))
> +		die("bad version: '%.*s'", (int)size, pkt_buf);

This would mistake a packet `v` for being valid.

Junio pointed out in his review that `packet_read_line()` already
NUL-terminates the buffer (except when it returns `NULL`), therefore we
can write this instead:

	if (!pkt_buf || strcmp(pkt_buf, "version=3D2"))

Likewise with `"git-filter-client"`.

> +
> +	pkt_buf =3D packet_read_line(0, &size);
> +	if (pkt_buf)
> +		die("bad version end: '%.*s'", (int)size, pkt_buf);
> +
> +	packet_write_fmt(1, "git-filter-server");
> +	packet_write_fmt(1, "version=3D2");
> +	packet_flush(1);
> +}
> +
> +static char *rot13_usage =3D "test-tool rot13-filter [--always-delay] <=
log path> <capabilities>";
> +
> +int cmd__rot13_filter(int argc, const char **argv)
> +{
> +	const char **caps;
> +	int cap_count, i =3D 1;
> +	struct strset remote_caps =3D STRSET_INIT;
> +
> +	if (argc > 1 && !strcmp(argv[1], "--always-delay")) {
> +		always_delay =3D 1;
> +		i++;
> +	}

This is so much simpler to read than if it used `parse_options()`,
therefore I think that this is good as-is.

It is probably obvious that I did not spend as much time on reviewing this
round as I did the previous time (after all, if one spends three hours
here and three hours there, pretty soon one ends up having missed lunch
before knowing it). However, it is equally obvious that you did a great
job addressing my review of the previous round.

Thank you,
Dscho
