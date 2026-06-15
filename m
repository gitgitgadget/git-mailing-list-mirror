Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE921CFEF
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515788; cv=none; b=WL07/L3PcL8eJqzxa27GAZpsYH1QhzsYN7QRYOsR4QsJNdMlkxZC6bT62GZTwsLfGGOT/sofuQAEhIY+DMo5wp5Vb7WozzmF55rpvMnjcV7LKoFTkqHLeFB3p3w9nkRQqrHSTSZWxzMMBIq5BN6Z9pVrN6fc0Rl2nzv1zjuJ4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515788; c=relaxed/simple;
	bh=iJjxjSMR1wUz2ZsSPGFRGUQrOKSW+uKuGblC1keOYWo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ERsuHGpgdPMWOMb7MkAV3WR+6DFfo3Kja10eWykuXzfkH4JZA7CQ5AKXKZbj9Ku7Wcd6WoE6qasKVLCTXg1My5V+axobLHaqvxIeXnvOVHUIId5u/JBLoaBYHrRgrKxqtNairtlVD/CtuMw4qLrZ3yoG3gvzV8rw4UFphtHZXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SIj51jrz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SIj51jrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781515784; x=1782120584;
	i=johannes.schindelin@gmx.de;
	bh=4NaFuHFJMYvT/MGHyjKjGY1iyFw+yY64EyvZLkrLEUU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SIj51jrzPMavEsVa2K4D2UjJHFewe1/koRXweDOpsFjUu4ZknpGlMY42P1BkE3R7
	 pbGY8V08UpqlkAWfjx29SZrUUyjhse4J+p377OcbhBaqTtAS0AZwJfUoaYGYCq0D5
	 n92KAVDXOFds9/g47rw8v0JGg8SJl3Oo5sNYvXXgMNZo7vzrJzJ+/GtdG55EtBYOf
	 VNRK8oJZo8/Fa2OPSCQuM7HjNWA0HjCWjHzF8kbsp9AuCOhrRuJwtREbacRoB5plt
	 29AmXV28LNfuoTX0j+s5Mo14xrHu+rIWnqyIgaFSNKo6Xa9pamA+6NTdEjX3Nf8oA
	 L7CCYn96RkkFkmm9hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1wt4hT0JfT-00OtiG; Mon, 15
 Jun 2026 11:29:44 +0200
Date: Mon, 15 Jun 2026 11:29:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 4/7] packfile: widen unpack_entry()'s size out-parameter
 to size_t
In-Reply-To: <aibJW3h4PaYhOqFb@pks.im>
Message-ID: <5e87910d-d8bb-76f1-d3c2-0e3d9e5d7814@gmx.de>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com> <bdebc36f21d1e2a13bc91d72a3ada1db3f7e184e.1780570273.git.gitgitgadget@gmail.com> <aibJW3h4PaYhOqFb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:m2DNlWzmMq902IgbH0GHgR05TZYXnXIkRzHrPPbArOf/a7ICFoT
 NeDV+fGfvWv2CQfOo6NDRoQmbH+faiElnc7SEDAW5DVLcyG9qRxnlAoFmo9mwCC/ddfDEko
 o1bAwJDpcctEAm0tscSzMxh2dsPAUeBhVvDKSaXhMOizD54/CKIY+vuwFaj81vbtK/EYx2Q
 zOd4TGL2BXbcTA0JvZuqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KV1BBBQv2X8=;XM9np8jPHN59vQX8NgUt53P8AQP
 N/u3wdqCE071JwjoVUmt7aYW29kiaWGh03zbNjJxwTsmS1qh7J9CK9j61xABECoVG2agUTeEN
 PMlDWO5/jZV+wuyCsvygE1ilDKshavM1dAkR3wsctxn43i2iH+SvmEWJ2DPtcFCQ86bQxtAaN
 +XAxvHXPYuKnvQaBrqtrT6aOLXA+ci4zDjSUjoztso7OSJyfDmKtA/m4l8GWAjHWzS6WbDtWb
 HmBVMGrblwZTIpy9dUtjX/EAdXaGZ18haV29cX5eD4sdACKjq/K043jvsbbDHmgUoEm86vZj2
 YJafutVyrzVDWya9nE9U3htTf9RngxftzdrX2MHOR7y5vP9yFO+pWT8pHA5oEOSKFd4PwsuGG
 CBTzyaovmQE9WFbkPNetpjs/W/mNWsHklbyyfpJSGqAeOb3o/oDAro84WOOM5e6qIjzdbbaYt
 Z2gbYrA3f5t4An11tbSWcrd1Av1tmEURE7SmQYwQfTY8t+EBAD18kUFYDxerWdotDLQk7WHoo
 76EqtczKZ0SeD8GfPRzlUvDQ5KMPXeHHT6oZrllIlW5mO5Z/SflZmA+jAYmyfkwO+KDl0lRYa
 fa82NVEQnIrhZ+0G//6XTF+SIeAa/xr8oX5VmOgW6dtIqDYKDlCr8SafY0F2E3kaoNPt1lEw3
 ZSCfVpNdzDOE61/YYJlYL94+5o/8D0+Dq/07aJmtPx7R/13NYJLhDreGDPnph6LSb+NbDb9xe
 ygcDZ3YnoVEQfWe3nzs+xpJwCUuGgYsD+A8m2hwLo8zD6rQkkLViofOso9Aqc5ef1pycBMbde
 n8O1st1u4qzNwNF87bYflitzNDCyqZBpeqebwVhV5/URKqASMjvBpUoloE/ZMhL/fZ6MaV6z4
 9VJXUAonlpe+sbqLJiaAAH8RRCm/Z1kJnrrjeeukdGHROVu09FkYTdEUz0DWyIIzt5LIZCZBK
 AT8y2QoVwjRvhNx/Sb9vJqNETepkvvTDHelMBTh9Q5ydBKcyn9wUIyinZCP3GGVFk/XyktJDr
 OsDpFCHSDlPULt6p0lVmNYFPBBYGJAByuSb7Feq6igqAfG4gpQBXrxhcfJI9wouzPhrn9IF6e
 zdEXO2RXRQb/h1N3H7mlUIBfZQaCm9lB0TmJtyp2l+DvGnkDv+5kyePUD73eFw1OC8GJpdreJ
 GsS7jw6F+Z4CNdxN1/UdS5YPYG/EQ9XK4r6wj7FzsBm6XvosZLn5oPC5qYR6Hi0JbO63OwU8/
 132+zGdInsk/Y4Bpnf+cXe5jckHfa05Od1nsc2OM0h/SixJ+DNmgBX5BiV0D2dqzaYCSUkpMC
 v4w2YFFTnX+5ZW2WFy1SgFpYBPQu935OnNLTUe97xJQgbXH+gJajfsEP79hK6QWNFgn9ta/9O
 LrNGPNNZehTPk5HpA2RQmMPyQFdbAKRSDUX4E+aSrgCRB4saOUDNTedefMbabLoQVml8CsbCQ
 QJXGz5joXXoO2a+r6bRm6DNiwe4R8LEmeuvTmd/C7PqzmkWAfDh0gA5V+x+k4ieWa+TFd3Pyb
 dPYpxrrsctHKtZTROZ5+N/ayqw7shGIZdH7ETBAmUogIHJ7fy18kPWwtcnElmRAocmB49fwwe
 yWMr5ISqSmcv8spKCj/rUkBSmZadpdSuCaMwFNWO5c9sGaXQYLUo/8WMuzUE4DAOVXBVyFjmw
 sIl9OCbi1LMrB4oYyT6Yo4FYslAKJacd/6t+xMbyGuVwpj/Pf+OOqKvkVtBzzivOJlnun3+e0
 kvmXvepDk0L2/vGIqqPJZE9iMhfEI6eSTnqNMciT3Rv0Qo709MazIOTWmhuV8JhP2RS19bZkZ
 C+3gFkOXR4alt5vl+SLal3uhSanRflHECAzeqYgT4vGZjGzSgWzpAiQhvDPaAfMXD/o6H1itK
 1fIyVcdLCytDoDJ9EhI902vLkfpdXgXXBvO9ZBtpgujlhhBa92J4VWSSzABzmxbeMh/DivJ7E
 tlKx5i3qf+/riV4j3ObEocyXjoN4VaDS5LgUiq9phd04mVICpq/f04nyimzLNRDQ4MyAMlorF
 Hvd0YFv4z6XU4bM0OtARSfuribc4RUHVTEPJjvMH0pyp0Lrr99DGTHlOAANLfMnVHMZQ0DJmD
 CqgXNTnXKy9NfBqULNDlc7zMIusQBn36064ru6W16krIvIvFaWs8r+sRIlaS0mrOuJ1CEgrOh
 LaquRGPCRxGohvdxTeblHFBnZxyL72PXiA6BikgwFO4Ugv5+s2mQXThtCTNAs/cqWqnT0hDkF
 LBw8Pr3k8WNVt8bVeuuSzSb780d7cbP9y1PO/Y/bjnaVpMmfpCTj9SbmZQQoWkYlgAJzsJ8q2
 ysz7oqJB01rf5c46dADMZgblLQDgaW+NmB4QrVLmzN9TDWoTqCjmH5CfS1oo2Tv3SWClXnvBG
 YCrq0kyBnoix8VNWHullf6oW/lWSGX5F1XUtilSYE6u/eCLlxGI3RPv36ey6Ci51W8kQSC1lm
 w2u9n7qlvnqxOsAjyweS4n/ixk0aw71AWOKi1LV81g6U/7xrBHLMhkzOTmO5IqNfOLHYUJDH4
 Guos8hdkakOSlf809rB4KE347wsjRwQl0AJ7PHcx/5aZ8KIQMjTH4uPx2GXlt7dIsv2+v4NuW
 8KrejDcF7/Jzb/ePK4pL/p/Dvm6Ru1QjXG0N++wCgprc0u1iYhtlAptseAEklcwx1XgvQFT5G
 fWk8/MiZdlSMKXeYAlGjVPG9kFVosXM1TC5JywM4nEztJve6ovYCaKme9Dlewng1K0/2tG3yj
 mZW3IC0jmOVFF/b7pROX1nfpt8JfM8mz7WTgiOELyl3mMJSEvk94EHt8vKw0mZjwt95O3UvHu
 LYFkW3sx4UkJ4v2cU/bBdkwSrMAPMqLaDhgMg+epn5mnxSXsQZOzUS0Qkz3X6/eTDZvvH6BJq
 hPvd2n8Dme6ORtcaa3j8F8PaD6Rv8AW2TlQ77Y32X1EVnPSpt//jYJ47i9byN7rdjGHaX/muz
 8JZFESnzhuPuu30YzOft9aZyMsvZev9RDxQBlfdm2EAId8W/sI5+rLpJFtQZiXoFvPHKQpWf6
 Dwpij2gCC2B5HbNzZ0UcEyV87YkZD78Siay3wyeGYCWdIsQBEmDhggM2LRmSFXzmGoTsx21jD
 ZiFdKMXq2x8zNruVDWObvdckhYiXgksWHXAsG+g8KrKjYiMwGXVw6omNxWaEwMQ7KSOXFS7Bm
 26Eb4eOh4GWgBGAd2tlG9O9zXIfNrZatkYqMpub/snLdsHrxa+qg+RJxaOgjjSyznOyphii4C
 vp/TTq/wso9wI0R1D46ea3+FPizb7UoLfkj8muJZbWWOhSFcp/WRyq1zpSAzKwMxg29FSiuQf
 S7G2lm8z+x8rY8vO6irqdj3Cs2rA4Sc6xQ1dHdA9xJpDAS+ZMf/Ic0lXtEWfTg5Jr4557UL77
 /9mgG2y/Y579hM+ZIgYuOnkWHaR4Jpp8RLsytd/D9esRiUgLf93na+9IjvZHWmUKw/ge99Ocu
 vgOV0tg/hynWTvAOICUaoqyyLpWKMp8478sKrh8z96Hbf98qJaScrSLGe+BLYMOzzn0pddZ+V
 v4O6gExioKQCV2qHSWZDUKWwfDXauuCeRYcrWAP8cQ2uEtKOjVHKqYVisyhQAdwdGEwX45fOZ
 P1FfKKDqVCdGJ7mC16G8P9nAc7c9rf0G4ODc6DgdQkLHr3KJJxvW4nqX5vGH8nsbXjvebGCio
 buIYM8hf0ZvEPD1+oA81cbAc6A4AF3jy1G1a26sVlIAPQ+LBvOo6TJHfoRx+oFzsrx15Kt8K2
 s27dqAQ1Nj/fIo8Kez797wLDCjDAQYxx4uBs2PYGxev2T/lOqRNeHpq567D5Cg2ogwlFIUbM4
 +MHecDrC4EkGO0u2CD6PcwNma6ERuhE2VW0Cwsx6zeYVtd9hoMbtiGwrMAB1LrUyAu1ezcfNw
 v+1A8ZU4b3RJwh8ByIQFELPP0YD8JQ3VFXS2Q1p0Oi3pIBg91jN9YiOh+3ZJ+GFbl+c68nCPJ
 5Fq93aFH9zEZ7+8h7HLvkfoJtParFITZjUbrywmun9juc6jBq6UOKCQl0qcfb7AiINsHf2zc/
 fXg1xkdi9vQy98UrF8ptbmUHzxgr4cPuZ7CWJvQQFQZxBa3Rg2S7tLtBCvkxgQmG56mboQcGB
 +CvioKv3yUwa7pfDcHXe5XLTqTXQtTn4RMTLM46qYYAUPl4S+PUJzuLqbLh7OC3rVLG/XDQHF
 6uIoS8G2i3wDppyW8fVRSQrIbHVTVtCCaFUg3O/jBaV/ieM00OOgP/SZGj9SgaRMDjr8IZ+dp
 PTzyHtuhllk5IdL54vWTqmt2iekFglFVIG1poyZye58FiQiP/gLld/cNw3Mhs/Zs9t5hz0IaK
 3ZMu38R8X2zUWmztpbA1CtuN6tHCzMDlsmSZCtsKUX6jq04C/zGODcR50BASaLu80bYckmXZm
 vAS/MYsjs9t2tNh6S9w+CcBsM1Z199z1ir6/vuiMjOewzltHy+afKbPIc6/nf5aIzIxtCe96f
 LRJSNda2l3nna8pWCI/tedKmbjNMGb8/zaex7y2DaC5AR2/CiTKoi9BF5kTcwUrZZxX1f8bKK
 fsW6N5evJWUw7rITTVtZeQJY93IT86vtZhBZ1yTqsKmvQ/PrB5vpUJ/fvP6sjMl/1P7p6XNTL
 YRuGM6IvMYji6a4qGg0JupH9ugnm5qqlUchr7OhNlY9FccVUe7QrWA8q/0RetrBHdOzZ8m4Vh
 NfREOnWbNjFfJl3h+zwAVQTcaVL241eUVI/BK3ZqHLyiQpqbQme68BH5x9EWkLS0N1VekBNBT
 7FNEf0qnoIl5nNJsZF6iXqQxSeSxREjJG9D2T2q2jUWctfBnSdUAwB20dfS2LLiO/AfP5A+dT
 5BIGbanugZLitHf4tu3HIJCPudEXyLQsrHueG4H+RRlRTnvbFTebGq2D/p8SYhTZ/0GI4bmXb
 LPilTyGuZaPvg44TLIA4pTgX1Ht52NiaK6IQSrtQnUH5e0gA9ZCCNfh3Sf12vDeVI5i1m73Qf
 yHdkTSMTK2g8tlveBQTnEXILW7rbyipgrsaPWMGYwEEj20Vk8tiwI/ea9S520jpoaaGWXyOMI
 7W5ojH/Qtf9tMIJeJCda2+AZQdPUGGkT81zMtlWs8bRgA7k0zxbmhRfrbKUbhYU2oHcPvRvGv
 bwa+GD23KCu9A/PTAuw1qWd5btLLwW8xNhL7/QptYZ9T5mL1NtfrruPxD030zIkueIbBoFJnP
 3cQTJRGj1oYC83/Gk1dAMP6cilbZD0Z0u0Ftfq11W0TfHqtCvevQa/FMu3fDDT8iUgvHU/Zan
 bXGU8bqhDvv830kYOX655DPrOimxGkl4lNomzPIsMzCaZ/A796qo19wSTBz5/FuUaEarXonW9
 VuZdmvgji3d/pPVpYB2ps7JgjGR5ZzbKGJWc13IMLEuZ40Rr76FLw6zaJMboMnQXgrL2szaMS
 RnronFxUqkpUPc2e3JqpNXBzLHaoWOVDCqdBNNWLid2iDa+4DqjVYPwRZGcAQqSNr802ANfEU
 IOzFYqpQ1SeJQXAAcPu60ppU5pJNkpyc1bLnlgZvfd33VFlYoIjaPB6VNfmgtl4Kl06Qkqt16
 wXisA2pSQAGyx0zyYbC5nQBBzgzuAkqOJIaAZjzPo1UGTQvN0UXPky+5MaRleD2ftWmLUA==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 15 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 10:51:09AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 82bc6dcc00..3dff898c43 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -1239,6 +1239,8 @@ static void *gfi_unpack_entry(
> >  	unsigned long *sizep)
> >  {
> >  	enum object_type type;
> > +	size_t size_st =3D 0;
> > +	void *data;
> >  	struct packed_git *p =3D all_packs[oe->pack_id];
> >  	if (p =3D=3D pack_data && p->pack_size < (pack_size + the_hash_algo-=
>rawsz)) {
> >  		/* The object is stored in the packfile we are writing to
> > @@ -1260,7 +1262,10 @@ static void *gfi_unpack_entry(
> >  		 */
> >  		p->pack_size =3D pack_size + the_hash_algo->rawsz;
> >  	}
> > -	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep)=
;
> > +	data =3D unpack_entry(the_repository, p, oe->idx.offset, &type, &siz=
e_st);
> > +	if (sizep)
> > +		*sizep =3D cast_size_t_to_ulong(size_st);
> > +	return data;
> >  }
>=20
> Nit, please feel free to ignore: do we want to add a NEEDSWORK comment
> here?

Hehe... My mind translates the `cast_size_t_to_ulong()` function to
"NEEDSWORK!" already ;-)

Ciao,
Johannes
