Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC8E20357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdGPLC4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:02:56 -0400
Received: from mout.web.de ([212.227.15.4]:52052 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdGPLCz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:02:55 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj2XW-1e4Nuj0HLq-00dJDN; Sun, 16
 Jul 2017 13:02:47 +0200
Subject: Re: [PATCH 5/5] Makefile: disable unaligned loads with UBSan
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
 <20170710132450.yxojk5cybejy7und@sigill.intra.peff.net>
 <de9c876c-f018-ad6b-3813-576ea73dd49a@web.de>
 <20170716101744.2g3x7v2dtasg45ll@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <840f246f-e735-2a84-d9b9-95d8e4a9d99c@web.de>
Date:   Sun, 16 Jul 2017 13:02:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716101744.2g3x7v2dtasg45ll@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ruDZeR2+Rf2hGXQqPtcKdmAOSLQys+j6xqqM1Pf/lhRsfF8T1z0
 42jQFLgpkdhl50m3+yxTv6kiKNjhBTEJIElou/8aWbUcA/VWBZQNxelzApN3lPE8jTBlrer
 Y5ifvS6VnVIxqThonottb1AfFA+L3+iLMbpKwSVH6RDsi0MjzWbnSVtd4fe1BBOo/Y8U+wJ
 iHHPOVRZJOTfDiKOE/ASQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YVBrWjiK9a8=:C+TqzSNABTVLNcM3pL6OUt
 G4iz9YDK50KL2ZGcYQzJDKFGQE6+rbAJIM22bqi6jWY6IjNS2fdQnUKaa/syRp3/rlWRzFGIE
 Sg8qUY7gUV92aW8FHy5xOBNuqtOj9zKowsbEA+/naX66/VtWc/HTsMF7RmWNWMpxP37eioeB0
 dWl4IxsnXKujqFXgvvBaWdYYjDZ+5PkCLxO7OUCynBLF/yMa1lFXTmyDFr0jTvXSHcOh/XXdd
 d+YMwwLFIJhOmO7OmZ3IuOBwhWrhGrS00Uu1l/W0IZBvol9zsB7aCHZHb1qdJyggYaFSY7hbv
 nR07I+bYGC24+JAJ6Ij9gy2V5+hVM04aq8mhV7oDxfZJZ+jsmSvTbIHvJ24uUvVSoxQrHJvnU
 qrcv5Oz0BvbAjXzJnmzzRUTvujUpnwufFq1nA6jKzjQv/Hd/HovBh7XNSle+t4swtMM+byIvG
 XdA03Fw/d2xbmEc97aKwqWlfadD4e1WrvcGn7jCEQ4OPsCAW4MMrj+VNk9FpOv7+FGc12gvkc
 rG/wVS8iZfUwquyaIkGpg63bYK11OLr4uQ2sXH+wcnkk6RpkxmJQ42Z1hnCmSNMbEj/u3LcwQ
 +7YvgbQMJbcMSz+POoItPqciyAwPciyBxRBaz3NTjQoAYx2re9qu30bIhzN+lQll+O6wRNrTe
 V5bzYEaJ6Znro+U72b/X2t8J7kzk7ksyYNGPR5TjoBtC8SpTh4E0NxhQv8fJwRubQQLfK3/bs
 k+Thc0aE7XioqpsWO4TDVP4ZF7Jxs3I5rUrTQDv632PXVZyY6rMP0c4jP8it+zLyQBw/Zc0q3
 mCPg4hFAesZ+J+q8LwgtJaAHbx/k1SRTz1E9EMUlgic/cev/6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 12:17 schrieb Jeff King:
> On Sat, Jul 15, 2017 at 07:18:56PM +0200, René Scharfe wrote:
> 
>> -- >8 --
>> Subject: [PATCH] Makefile: allow combining UBSan with other sanitizers
>>
>> Multiple sanitizers can be specified as a comma-separated list.  Set
>> the flag NO_UNALIGNED_LOADS even if UndefinedBehaviorSanitizer is not
>> the only sanitizer to build with.
> 
> Nice, I didn't know you could do comma-separation here. ;)
> 
> I always just built the various sanitizers separately since I was
> testing whether each one worked. But if we can get UBSan to build
> cleanly, I agree that "make SANITIZE=address,undefined test" would be a
> nice thing to run periodically.

There are *some* restrictions: You can only use one of address, memory
and thread, as mentioned here:

http://clang.llvm.org/docs/UsersManual.html#controlling-code-generation

Combining ASan and UBSan works fine.

René
