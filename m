Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F216202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbdCOV7R (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:59:17 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34507 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754000AbdCOV7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:59:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id v190so14586663pfb.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjTrF/B0t3AemP1b5Vg032oNfP0UGbbpbzOsVuw99kI=;
        b=VMcDlM5vXMa7+l7eSaFsgSCSw4EbGbjf67aTCTppuC/qPknMXeV1ssdO5XSjVfK4MJ
         R5AUj6iNtBUHOrU6jcrUykdHYGAVMFY3vyjB+P5GgV15VHz7RxCIsufP0jzHrwI+KZ+8
         4G1osXcaEE/uCJQwMqUQS9MLUxtBiza73z4bDMguP/kThB5l1YKBckefLDFz8fkNHBG0
         IkNkRFtjEblL7LdDIh1OCRGBpCNorueXM489d2T0583YSL9TR2KlVGzpEmvmshN5Bq4A
         xiNFPDhKIaOWVdSFdqRDW1N91auELwJ8evc6yg8g8zwVdOL0wD1nWeBS0Scy74XbsHrX
         Z67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjTrF/B0t3AemP1b5Vg032oNfP0UGbbpbzOsVuw99kI=;
        b=OX7VFvnAiu4oy8KEf/3Ebh06R/SFD7LC4fdrwymDuP+REHEbmuVeaPD1uHKUip5RgA
         zMDmQ5sGeoWlLJ0Q3CPXNmscugIdHm+UAzJ3KZ1fG86/eb+iCaiJ2In9yF1424wZbnbm
         0M6cG2CLxxnt7g57s/jrTZt13lcVWTqddmujTbZ4d6y+lBd68PRC+WH6BeFlWSLHD+IP
         +tKTrVWYEx93GJ6DiqVA7+dmG5b6pAG8IRrg58tl0Ws6l3CjT7Ii7BTdY6H+rflgmx5V
         XIYtLTi9NfT3Ew+HQs99ZoWgqbZQ3gicHe341WTI1pT/quqJqMpVv3oXmzNZsxtUC32z
         o35g==
X-Gm-Message-State: AFeK/H1KU5cmSnkbTgWtJfphqUZ00YIy/yzaXG7siLcQtk51bqfnnV1guCfWumCSXo3jqmGh
X-Received: by 10.84.233.193 with SMTP id m1mr7639181pln.118.1489615155161;
        Wed, 15 Mar 2017 14:59:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id m3sm6102567pfc.66.2017.03.15.14.59.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 14:59:14 -0700 (PDT)
Date:   Wed, 15 Mar 2017 14:59:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 10/10] submodule add: respect submodule.active and
 submodule.<name>.active
Message-ID: <20170315215913.GF159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-11-bmwill@google.com>
 <xmqqefxziqrj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefxziqrj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +	if git config --get submodule.active >/dev/null
> > +	then
> > +		# If the submodule being adding isn't already covered by the
> > +		# current configured pathspec, set the submodule's active flag
> > +		if ! git submodule--helper is-active "$sm_path"
> > +		then
> > +			git config --add submodule."$sm_name".active "true"
> > +		fi
> > +	else
> > +		git config --add submodule."$sm_name".active "true"
> > +	fi
> 
> Why "--add"?  That's a way to add new entry for multi-valued
> configuration, but you do not care if the old value (if existed)
> were false or true---you want to replace it to true here, no?

Correct, that was a leftover bit from a previous version of the patch.
Will fix.

-- 
Brandon Williams
