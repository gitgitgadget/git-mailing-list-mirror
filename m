Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0234041E6DB
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925598; cv=none; b=rhQzIfOhXISx7QVV4FUusVbv90MVz6swv403sSId8I2uu7cHVGB/9DfWBfOBIeMu1E+iFU/JGgPO4cbU80I9R9yj18kyc2okKBykpsb+SGLSGa632cp3eRy9sFdXxI9MqrJzVTbhmkRv6P/R0YbXh9yCqVwLu72C09Mbg8O6KYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925598; c=relaxed/simple;
	bh=N9nnUjC1ewddHAMda72ChXPYGArEZ0fLXBvZ2XJJ+j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMrsXC8gyHdG8YScw4pHZGV8Q2a8Lf76I7kKV7Rf4WNEsvbHQCe3J9WAlPNhxDkmU9ZO9eHAAGLrHXYjTowU2Of27+wNZ6qFEqi9M8d0kWSfznw+aQjajrXwqLHktoYl86rK2VRZLRBPdBSd02wQJBx8sL1ovDSRw5WLACpGH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uN1712ey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXiLfKQk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uN1712ey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VXiLfKQk"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id ECED6EC0285
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:19:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 02 Oct 2026 03:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790925595; x=1791011995; bh=46OIJFu1ED
	rHPh1+qpF8UefBZgYTkMpuPJIppxpbgEQ=; b=uN1712eyw1YRW3wgWhxxJR1QVs
	YpTQ8lMIWN9H7hqK898K+S81qnsr3K0Lg8KReXLiprVgwUML8Dkd0rIe0aMS68u2
	ZozKu/mKKNmqixuF1EGqx9gVx/gT/KpBTQJDJ/eS6hRRlB5R2AIWtR0APJuWKcEr
	9yDQ0iKofJADFjbh1yqTzOq00wplRXQHJejxs5zEp0dv1jBuhAdqT78nJUzVABjH
	Ieshkn7lI/Xo+Fiz3pccd+IrentKnTBXdP4KKGtakRovah5ogHM7zF3hjYXYCvWS
	M243PuWIe7nkuXIyl/7M5miu1azh1G+klGV3r+pDoh0f6Rj3zGBfrf/kIDiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790925595; x=1791011995; bh=46OIJFu1EDrHPh1+qpF8UefBZgYTkMpuPJI
	ppxpbgEQ=; b=VXiLfKQk3HKnKFJAsS35c5exJbdmR3HR9wzb3oxEQY5s+9yaD64
	nMVj3+jHnxn2kKAkMYBlao0a5EMcTXztOt2MBUOKWgqlm3IbsOfxg+2O5hHN4hj7
	Fj5xdz20B0bamLUxMeaubiXqZO72jbwjrGMmkmR92cSurKcIMavMJPd+97wHvqFc
	H/hQuBOuluPIc55IQYSBlTkTYnq65CbRiT1Olyyuz+8FgDLW13VLzExB+io3o6v4
	nMrsHBRTk2Ea40HRm3CjEXTgKR1Glhw/E+WURaj3K/dRmWlYaZ8XUhbZKTKASXQT
	OzVyiiXpZgvh8RMfxa/6eqJBi33XKXEpvBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790925595; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Me9FzAj8podKoBpDDpTuJBZatLHAq10mO4JXS3FwMrEjwak
	enDeXCe5oMfxij9goi3/Uh83Mg/pKLwP9yKpkxohz+Iea4I5J7oxNwGL0oZ4pSN2
	5YGQ8wM3d5KcO1U5HGux7EMV/QuhLXNruATG9M5nlQxDpRciQl74HCjPk9nLB2tD
	Ct0B3pLqXkNabIBTU+EUHlc8BgiDgNTMa2qv8XWezAWSYHoDT9EbNuxofFRPJJFu
	H2uq1SE1kLjgJUWCsnO9R9knbXQ1NYuRoRo9VCtRs0e4870IZ/3gBlx0+xPnjBfs
	lzaZxu+c9HRQ5ZFBW6z/Iykr2f3Vy7njbfPP6pw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4v/55yYxbvl7NO41P7eMnf+BrIlCsQtG+O1mQGHXPkE=:N9nnUjC1ewddHAMda72ChXPYGArEZ0fLXBvZ2XJJ+j4=;
X-ME-Sender: <xms:G1u_ah0YVxxpabFCxuO8d3_nuLoM_h2KbQ-vzeO-dB_Pi2DuhgU9eQ>
    <xme:G1u_auHxDorY0EaMESeOWE82TJLfTwXBxJaItZz-fetpHQptgbjACDd6Fv2JJj9Cy
    qpV9yAFa0SNrHIwFfUSZQEPKOKyjZaMHO4JLFTo3rgHiaBolTtQzec>
X-ME-Received: <xmr:G1u_avgYYoPUk7PIP8VD5JEFqrcqzkiOzIcZq6w5PcEllOxnNZxeEg>
X-ME-Proxy-Cause: dmFkZTEukxZF5QZ5MxW1jFkbFdOMivy08vNZIXtjzfFniRrhKe57ukWLoyQu//NdmPYj+y
    45RXcCtHQ1JKZKtFE3uMP1ppQzMSlxazQANFiir32TVMyNnrDMAWCwDE3ieRZ1x0hZrm/y
    R26k2XSW6TsUtoxxF7HDaOquuXTYzzjRJ4Qq2g9QBSMSr5IcnrjTyvcqwcTrxmmooRGkPd
    EacmTG32cXN276EbNPm+kE+kk1FM+W7SJuGyBAVTE4cvtqRvXEcSIxWvDFtzXfMX69X5Vs
    YOT/Ti1aiOyz5GmKxOGxVbTYFXwlcgRBomRzWwy7G0OMXQX/gQo5+0zb1QNDylQjMtQObS
    6lxNhOscqHIP/E3A8L5af6vwCB2EO1ksPXPVVkWW52j+XNKoxnG9wH+zvSG+wcT8K8VI7a
    QbJpBZcnspYkjvuLh7MlYYwqwdyeUuTg7fhHgNgfliUGTXmJkZtWW0dXWh8lFRPs5dttal
    zfdcEoeEnpl3o+laOOcK2pWI59yL/Ypr7/CTFqYgJAuITTeFC40jQJaB5DwDAdXcZim0Ur
    n6fAdFEzcUR+J2zWwvuWo4g0DwGo+WKq7SO+kqIJaWbs6wlSk1dtYm1Ooq6eMN+PnxV/DB
    /H/y/PAjhVWwO7h/8WKqdEviv4WU2A/tAZaIwtKxKWvl2c5NDYZlbwu7rI5w
X-ME-Proxy: <xmx:G1u_ap-6rU_hkRH7XTcHqVCZwKoj0cyX-iMlTb5UrX-paSsMy9Kw3w>
    <xmx:G1u_amrN_djwA8TaOTw8zhtJ3i6uen1xS4fUZMTcNsHuMYNcZMyakw>
    <xmx:G1u_ao-d7VEz9ZjcXXUCO2Lk9d4A3ByaVf7OOc2oZs2dU2Aa0cnohA>
    <xmx:G1u_aqVCI3sgcmKQChLa2HFmqj6Q_Ay-Afvc60ZVW2Et9gW4lCGyYA>
    <xmx:G1u_atN48_DqGgPJuWJMXjlmoxGKiwqpEk2X0QTEyN4E7ypjvZfK7t9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:19:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e5a6050 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 07:19:54 +0000 (UTC)
Date: Fri, 2 Oct 2026 09:19:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse-options: allow grouping subcommands
Message-ID: <ar9bGF9NqIcol256@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
 <20261001-b4-pks-parse-options-subcommand-groups-v1-2-01eb2f4a4c32@pks.im>
 <xmqqcxtt5n67.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxtt5n67.fsf@gitster.g>

On Thu, Oct 01, 2026 at 10:46:24AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -1432,35 +1432,39 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
> >  		}
> >  
> >  		pos = usage_indent(outfile);
> > -		if (opts->short_name) {
> > -			if (opts->flags & PARSE_OPT_NODASH)
> > -				pos += fprintf(outfile, "%c", opts->short_name);
> > -			else
> > -				pos += fprintf(outfile, "-%c", opts->short_name);
> > -		}
> > -		if (opts->long_name && opts->short_name)
> > -			pos += fprintf(outfile, ", ");
> > -		if (opts->long_name) {
> > -			const char *long_name = opts->long_name;
> > -			if ((opts->flags & PARSE_OPT_NONEG) ||
> > -			    skip_prefix(long_name, "no-", &positive_name))
> > -				pos += fprintf(outfile, "--%s", long_name);
> > -			else
> > -				pos += fprintf(outfile, "--[no-]%s", long_name);
> > -		}
> 
> It may have made it easier to follow if a preliminary step pushed
> the above to a helper function.  It would have also prevented the
> nesting becoming too deep as we see below.

Will do.

> > diff --git a/parse-options.h b/parse-options.h
> > index d7f896a933..5249404b46 100644
> > --- a/parse-options.h
> > +++ b/parse-options.h
> > @@ -401,6 +401,13 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
> >  	.subcommand_fn = (fn), \
> >  }
> >  #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
> > +#define OPT_SUBCOMMAND_H(l, v, fn, h) { \
> > +	.type = OPTION_SUBCOMMAND, \
> > +	.long_name = (l), \
> > +	.value = (v), \
> > +	.help = (h), \
> > +	.subcommand_fn = (fn), \
> > +}
> 
> As presented, _F does not allow you to give it a help, and _H does
> not allow you to give it a flag word.  I would have preferred to see
> OPT_SUBCOMMAND_F to be extended to also take the help text, as we
> only have two existing users in *.c code, rather than adding _H
> variant that is incomplete and keeping _F incomplete.

I was a bit torn here because I honestly wasn't quite sure whether the
_F suffix stands for "full" or "flag". But okay, let's not introduce a
new macro then.

Patrick
