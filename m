Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C361F404
	for <e@80x24.org>; Fri,  9 Feb 2018 05:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbeBIFnp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 00:43:45 -0500
Received: from mout.web.de ([212.227.15.3]:49463 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeBIFno (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 00:43:44 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Letkl-1f35YI19F1-00qfyB; Fri, 09
 Feb 2018 06:43:33 +0100
Date:   Fri, 9 Feb 2018 06:43:31 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, gitster@pobox.com,
        sunshine@sunshineco.com, novalis@novalis.org
Subject: Re: [PATCH v2] name-hash: properly fold directory names in
 adjust_dirname_case()
Message-ID: <20180209054331.GA8337@tor.lan>
References: <20180208004156.36224-1-benpeart@microsoft.com>
 <20180208192333.7436-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208192333.7436-1-benpeart@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:5zQBjiuBegjAcOLqhtfd9/YEnVuPRtQ2fd6RDr3oK+RchvUadQV
 scPgnGeb5GugWFp7BY6z3eHy1EhnzR46Gx/kEEwI0e1//0MqoCFapDF0h4oJC5tYFzSipHi
 DxhA95FagRO2VtsNHUOSBnhZ9/R2V+J9GwrQwQqZelvnWn91JpT1gwbuDrmUkJwoJh8TZkj
 s5zv4N/FVNDDon11UiAmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0nWK0Z0JcWw=:5fXenlY1ABn+cde8mIyokO
 psJVDDDkxTfYzy5YJseCF2ejl7CCCWBKNHcPGJ5qT57HUQWgYw8URiHAWL8I5wkqn398I1EKj
 QFTwZ7peQVbQ3joZZ3jBVG5/7y/Uust4nkHzxbBV5K5LJAvydSsXs8yF/rQ7LD9nbubgmxYMz
 LHRg4iJaCbGsHpZt9SwROhpvqqlR26wE4bJ2ByLMZsdKNiHDUn5QSOFS2aowzaFCrvjcG55P7
 wJYxX6Lxx56JSmowjs9AwHjYD9WbJvvIAUVY7AVeQHLCUbZZ6fxcblJpnAIJ/Z+R71wIiueFN
 dQNd1rZjzJHVckWM6mtcjf9b5FnqeXmIkT/8x5BIN6RAFnfImaurigVI8teyRsDA6fCvO6ERf
 ZIT6YNEqz3wD5sQVRks+9iX9vS7JkxB+eyjUy+fMWnqZYBPAWj6qZBxm8IEVaow7FfVuhVq9q
 grY1HI6I8Hf0gzcE3jcty0h/O7/elodGlfqa6+1OrPVpgBuiwe5XdSvtFqT70SGVlzfbwcHWH
 mK4ttbdEUxbjxA718DyD0JGYcmGd1s/3UVDITaW/TZqvSEcCfAa1IrRKv/Sycph4YkSoUbO7y
 eCtM1iPfOIr8R7YnxErzE+sv5tWbOb2LFj5QS0xxnDPZ6M6oQ+DN4PBgKsCaYJdCX7YgY3amP
 kKvXcXgIRxOTsBLMhftzJy7rOT96OZ4uY5uCWDGQOCRPPdL0HejLfwYLTshl4I5MVuklLB0Vl
 yv95aZfrLaSO6mngzAUMgnGAIr6WoDGY2SogW09Bu/ek73cdv1y3Hk9Ig6ScOf7EIWYt1D33e
 DqWjTpXG/utljnMo+OfhswD8EIIeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 02:23:33PM -0500, Ben Peart wrote:

[]

> -
> +test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
> +	git reset --hard initial &&
> +	mkdir -p dir1/dir2 &&
> +	echo > dir1/dir2/a &&
> +	echo > dir1/dir2/b &&

Thanks for working on this-
One and a half style nits:
The ">" should be close to the file name:
	echo >dir1/dir2/a &&
But then we don't even look into the file, so that the "\" produced by echo is not needed.
A simple 
	>dir1/dir2/a &&
is all that is needed.
