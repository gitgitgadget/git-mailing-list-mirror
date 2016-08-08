Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296772018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcHHSQa (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:16:30 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38279 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbcHHSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:16:28 -0400
Received: by mail-it0-f43.google.com with SMTP id j124so90123826ith.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 11:16:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vp8s5HDXHtx93dWJBCWklY1LiWmPIrHr8WEnNPVPlLo=;
        b=V3tN+BuhBS5M2dfixccD76Ogn2c6Yrb1K+Hw77hZsMh8RiHmBgzL9/IpIpHQO5Vnn/
         x3Tr/cWE0FFr/y/aBB05igzrXWriCdTN+L9n+MbP+CE/IZDIxSh6ASBNZjs7cD8tZ+K3
         hx/z5AJR/fuhoiG/0s70ZIpr8etU5vM3/o2pNOvowLTEjScHA6fx728WED81lripCs3p
         5g34fn46kwyl9i/Ok2AdlKtEXBr3gtSZWILCvY4gZTEvtpEi9rTweeoPDIlLSVy0ceQG
         LzwsOf9c7PCnlhnHq7VMhJxIXQdYTfzLEVYvQZuwKDmwUE+3xtnYV45L/m02KHwv9E7b
         C8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vp8s5HDXHtx93dWJBCWklY1LiWmPIrHr8WEnNPVPlLo=;
        b=N64YfIF5hkIrUOHgN/VekxaYPTVNFpmhizLH73rk1IOPISdA6cQm2sY8T7lo9fUshj
         aZ4VrhypYWmL4zGC4mzKuAP8BOIN03LXN0AezBp8BQi84Q+jN10Hl9ECzzdxDbCuBgI5
         gclsjt5FDOxhFVror+5m/lEJk1gQU/5pAx0sKKY/fORFB1KBjTSC3uViiiXtzy5SHRu4
         hH1Jqsu32VBeGLYK9Qtw4pGxqWwBF38LeFXaKoK/tLbBAPcmdfRbK8br/UtY6eXtEFIF
         UIRtdRXDJEMRSmpfvgLLkS/MkoA2yO5H7x/mWeIRvIU4wY6Xv18rasQvukSyEY7UEB2l
         PXww==
X-Gm-Message-State: AEkoouuJOdapAW4WDT4ywqOgBgUZk1zA5+R7NS594nSEZ3QqbNI4PvoAS8Rxt83LLTZOhVtuQQh5Vwel0ecU/CDA
X-Received: by 10.36.127.7 with SMTP id r7mr19670936itc.49.1470680187467; Mon,
 08 Aug 2016 11:16:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 8 Aug 2016 11:16:26 -0700 (PDT)
In-Reply-To: <xmqqd1lliz5k.fsf@gitster.mtv.corp.google.com>
References: <20160806012318.17968-1-sbeller@google.com> <xmqqd1lliz5k.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 8 Aug 2016 11:16:26 -0700
Message-ID: <CAGZ79kYryZkMNj3_OLBU_fq-wmc+6a3ZmNSXrwVBB1jAz8Sc0Q@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 6, 2016 at 10:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  Some submodules in the referenced superproject may not be there,
>>  (they are just not initialized/cloned/checked out), which yields
>>  an error for now.
>
> Perhaps you can teach "git clone --reference" an new option
> (--reference-if-able) to do this?  Then
>
>     When `--reference` is given together with `--recursive`,
>     the reference repository is assumed to contain the submodules
>     as well and the submodules are setup as alternates of the
>     submodules in the given reference project.
>
> in which "assumed" is a horrible wording (leave the reader
> wondering: "so what happens to my data when the assumption does not
> hold") can become a lot more reasonable
>
>     When using --reference with --recursive, the --reference is used
>     to specify a repository that has a copy of the superproject.  If
>     that copy has submodules cloned for itself in its $GIT_DIR/modules,
>     they are used as --reference when cloning submodules in the
>     resulting clone.
>
> and readers expectation would match with the reality.  Their
> submodules would be cloned in a regular fashion if the central
> mirror does not have it, and would take advantage of it if there is
> already a clone.

That makes sense.

>
> Come to think of it, do we even need --super-reference?  "git clone
> --reference --recursive" is a two step process, in that first the
> superproject is cloned while creating objects/info/alternates, and
> then submodules are cloned (via "update --init").  Can we make the
> procedure to clone a submodule always look at the reference of the
> superproject (i.e. objects/info/alternates) and try to borrow from
> the place in it that corresponds to the submodule?  That way, not
> just "git clone --reference --recursive" would take advantage of the
> existing mirrors of submodules, a user who does this:
>
>     $ git clone --reference $URL super
>     $ cd super
>     $ git submodule update --init ...
>
> would be able to take advantage of the "what the mirror the
> superproject uses already has" when cloning the submodules, no?

That would work, too.

I'll implement that.

Thanks,
Stefan
