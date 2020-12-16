Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB7C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D5F22573
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgLPWJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:09:00 -0500
Received: from sonic304-13.consmr.mail.bf2.yahoo.com ([74.6.128.36]:44234 "EHLO
        sonic304-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730024AbgLPWJA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 17:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1608156493; bh=Lu9haA1qhU3M5BKqSszly8GST6dzVjWLh2VrLTQRy78=; h=From:To:Cc:Subject:Date:References:From:Subject; b=r0MtFfzCKcVQNBzxFK1uZiNrB1la3moTjemGPmP8h92i8At4zggf81/Mo/bjvAsN48bJPvs32RT76GDfq2LJkLcwAj+x8fRxL5wtMVnHBdHE6mkChtdo6UJA856B6744Pg2pBAVpwqyx3P4TQU2RspKxR5yonPr6yXd7epSl8AK07jlgyI4Bf89yGLF8nnmOeGYE9Gj1hWnwbT141CfOLwecKKkIi9lSCc7oO7cmIe6V4V7T6e+O/xI7K4wDLtKj5ao3aUGXFRs7HHQIN/lrm6d4e9zXpJPnBSee6Fq+lSPitu8HRp7UJuWiRmUTZKYzILfWrgp8FH8oGUraBO12ug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608156493; bh=y1N9cPzmOKbHGxpzHes0rgX7hmFwiB/To3PZljG2SgE=; h=From:To:Subject:Date:From:Subject; b=jCyz1ypoawpzZ4li8pLNeeMI/TD53iOZne8uT3NJh5NPX/3nuriqtbORDt8fgRGLpau1GVckFJCQCdnS9iM9WjNDHB1mW+aqNcnQb+7KSUXJcW/3KXR58MOFg9Y6z5bOkhQl8jPjvWyJa9xvuYeeenbq+5mckRroSE4tWW6VBlOvZMO5oej+AB7qQmzkxrNUVX/4Gtt/kTR90GGOo6T+og+Srf71IvkSTTEgMablmqyHjMK0HA1WqAOayKRyMw00+WOGB9o8RYUTQHYvOn2T/UFa4PLYFWglenbo6VzgefgzMCJvMQyYa3qEUVtD7PLRFpi8hV1VRURRp9hO4LGQgA==
X-YMail-OSG: GGuwxDkVM1kvFt_zma9a3B5kXEhXPA.RLr2ip6QWsOUe_QIjUzOGtaDYUoBQsqa
 EevrgHgEytHuiyaZAVDMebiBMklj3u.90pPux7yenOaPWCATbZc32hoozGpaNerbTNRWoab3s_ze
 m0rrVR217O5tugNqCB61YEsJUWDHmlf3._5HR2d9IpXjzdrAPg8F33w5ep2z7Q_.HPcP6bWgeF25
 wft.t7JVASyuikwZ_DtuotrQwqcMBAk57nSCKFc7o7imlyZAd59a1G.h9kJdR9tqJ0hEfUY4m2AO
 SlBW9L5tXH9x.OmkkeMT3zZHeeZIKKdCoTFzMSHa.FVmt7cD2lfOFhwZpRYx4rreW_UyNfk8Lyt7
 E2BkX68sxnMZI74PruPDwL1xgMj2zGN2q5a2TVlK9oERIL22qUMtBB4umDWnoCX88Ll838ha.2di
 PnlIMNuUOF18_qiZEkXJyOw..3Q1WF0AKNDuxsRZ0D_qLD45EwTAzTN2FqeCxl_oHRm5m40uajCA
 95lXuKVeFbkolHnghFmfLOyVzxC_ZiPpVYrEMNvlvPjA2MwV5HvodoOeQryPBuBn29Hrh4xoHY1A
 S_4OxFwG1UvBGU5305wdndy7TnnJ4xkiOrfE3kMAXwBY1iO5rVALVpTrQdPbV.wsgFQ44BdOlDH9
 LrAVLyNhEUTbUe7tcj6uH2JdiovpO_w1pBKzfGwd.ZFWVDckcgl5NllbgLCUyEX3zOZvGf6N1H9N
 9drkgxTgmotiGHp4TBl_IeCRPWChOHEk1TksZHc5uytfLndUUud4cyN7GU4nMehy3qTNYM8m49yd
 80iYunUebRwyHJQwKIl9QfAQULU6kL4TYYyqcBtbWU9GzypD6ySKn7teLXj_VYY3Me0zn3zBP.E7
 cCBTL2kSWgChnBjfb3dbyZ0xnvpwG.8y4jUIO_v.jPn0r03A39yiir6p0r_IqkpBWagI2DXdwWay
 DMAiaPkDWeOwpV_NKhc5Ot2H3BIlr5xthp3WEqQ407D7_UOurB4NUiF6ppDfZCD2qo2FgBYY6JFf
 2aURtjkcHUc0I3hMb8Up.8rqGr5yEYIZ6F0d8WuVgShsx_8Ndda.8ZNUrakIup_HquSLHbkXr0Pn
 D4cN4fMODnwESvCQhaxTNUGI4pHiz_VpkSDV2p9KXaA4gtgu0D11seCohhXyFKBeyHdyHmXeBRqk
 QFT2EFt6VdNtsaBa_uazbMEdpzE6ijUHuqYCQ6m7hDXLIjg3JUqy.PPzmrpBxowefoKaYz62YXk9
 R7iDtucnSJx6yi66hRbvjMdh5R1taDK0dMhJARCpH_i6wFhzj_GxYJb4gymb9OJVR4mU3QvqOmcP
 jJWD8T0XfZ8EWl8ufTyuNfLa2yIapKz5QdHU8D0ZTHfCgqY.WHc1LUZG4_p.uANbnD1UOUQE9K4B
 FtuNdg5GlTD5kqsCuPUcds369qOLjnGq4cRi9afESyiFyKHmf.auYQSESgtJ7TRk0LYY9lEY9Wkg
 j8wCz.cc9rlPTkLCNDalgHO1ujmniVcDkMITfPp8rcMKLjlvHpLBj7Mgn1ckKKI4ugMP3.KZZ.mc
 D1VMliVzsyvXR_1tRqw1DFdVa93DOIevdvxL3wil6GhldiBURcwIk92KGxhMsVFSBHlASPGDylZu
 2M8Y8j54A.JC.D5Pydzgcn7PH715TTfv9chtNBr9z.Xca7Ckst8.BSRC3LrNVEI4_qE5pgJ.bxt8
 25QGGDPgBwjDqODLoQQdWObh_9Orsk_UVgpx8LeBvmGQzNfF.cumjl54.rGTri9RV938.E66HVv1
 WyCa4LXHMhVOPzF9kmqPh7TMCBI2ouFMgJ6LfCkMuETTD1msutG5JSNSZ3vcMa0zTNKLNpszkYDE
 1X1vO3H6UvpF4IqmCfE_8RJyaS3uVMSpS4NJPYXryIHtw1I1pMQfJXt6P4TAByFdLvgENvxfCVAF
 Fv4gnwIDjXRkPCzrSl0m0DxVvcgS7pDV83y9cxhFNYQla7j4fKPjhBBfNpTKQKZ3I6r.bfgUhGjV
 qIip6PtNHnCtg3q_jOolvEOI9SCAmcd1Lakw8deb9Nvfypexe0u48WoI6rcVpbEJiR2UeSlER7qG
 p2ySFETKNp9fNU0vAVEaiHlcd.OnpyWxYPG_tfhkCyjOzk7f_BPbwwRWX1IRZszx2zsgkVpXNvHq
 J.Fsc6yhP0qasYWz6ny._xWQpNMqvPjXeysvF_cK8UCxrsJKWpw6M7oQoze_Qks_SEJceJXMjvmk
 tsQ6CY7MxSlEz_5Mpf1eWjZdHsWZXejPQ8DDBzI_CDE1yT9uf6EHo.RTksV8r7p1ZniYQKdFSjpl
 ycfcefR3EXC3ewfN71kC90A89mkG0zMLsU3n74DWwVsdFzLX2Co2aSySW4ZTDPy.fsMMP1jRTjIU
 6bGTbfxakYbBjJVFOMQ_7WtIe24T3UHJuQj13a7xT3cyKFN4Hka85apUJ9_j1a7_SVv4kHDbAs09
 r2HChhlRmS5U33epMuAp343J3UDByJGOldaw8v2ShPdEsktet2p3NgWCkO6GYZvqqvZe_15iiZtG
 g3ksiZuJQsTDtMl3zLVzO.KQSMinPfRlWaems8IO2uhSwyF9hoRgLMHEDSnjNwIssww--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 16 Dec 2020 22:08:13 +0000
Received: by smtp411.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b0561eb04c317a8b2712f91f841e1bc0;
          Wed, 16 Dec 2020 22:08:08 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 0/1] Remove obsolete compatibility settings for NonStop
Date:   Wed, 16 Dec 2020 17:07:51 -0500
Message-Id: <20201216220752.6371-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201216220752.6371-1-randall.s.becker.ref@rogers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Since the original port, capabilities have been added to the
platform that no longer require compatibility emulation.

Randall S. Becker (1):
  config.mak.uname: remove old NonStop platform supported settings.

 config.mak.uname | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.29.2

