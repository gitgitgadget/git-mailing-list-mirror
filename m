Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB0C1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 09:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJFJyZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 05:54:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:42499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 05:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570355650;
        bh=BJIvLMTBunjrYiTAl42mBVS1w3TFQcaseDzvWKBDkBY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XQMlgEEJwNEreMXjUazJs/mgDZmETuOrNd1hkGb5TDPwjKjm2hGZaNTIAMjWAXsqT
         gPT0OqGM1N8GNP6DG+TykVkdZshb3mOzNYg3QgIJYuBIcW+/b3kwgVNLROa/oNup8p
         JOc9vEM8zMriL9P5B1octLnFNUcjIHMh50Ci/mMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1iXtGw3uhT-00LnAY; Sun, 06
 Oct 2019 11:54:10 +0200
Date:   Sun, 6 Oct 2019 11:53:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/1] fetch: let --jobs=<n> parallelize --multiple,
 too
In-Reply-To: <xmqqftk67r6j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910061151440.46@tvgsbejvaqbjf.bet>
References: <pull.369.git.gitgitgadget@gmail.com> <pull.369.v2.git.gitgitgadget@gmail.com> <93a155a000571df3f3f3a63cd8d886d68fbe8403.1570301198.git.gitgitgadget@gmail.com> <xmqqftk67r6j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m6Y7nSG64rRnxfo3fITKUyaZznt50Cfizgojn37+f2TSVJVrV5V
 C6KBJGPK1wXQ8GG2RrrDBETRuBx+jVQdiRqb9NEGEZ3puh3oZhKHYGEjl8WkvfV4WMKngcA
 kU7LbNmnQ5+xjzXiVC/YfMhzVsLxTo9ZOdFnTKPhZK9h8oAY/nXMG1uFVrEwBb/0r0l56uM
 ppc23ca6E8jxtbOCFUGaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z5nVs4VNx5Y=:6sy2jfDWTG+78jEeg4qq82
 wXoqnanE2xDcGOPcrI7qop/F2aWE8i7ObFFepMxszR+coNpyEZvdnrtGiRNlJqmVKbnN+a+nW
 jtQEtTvISIA//XeFr6Ga4FPidVXAEhjxIpqCAfiBnbxifCMSqyksDeDKkDGcOIhtVUSQgG4yO
 +pyxnm5os34wvniABE1e7nfVBLSaRhNySIHhAVXXKgqvm82k84pLg1htcMpm5fxvv6grNWeyF
 jTX+5gbY/WFu03A0FrCIVO+TjkCXmplVtxMGgU+l7367d/L9IBfsV0LMlz5f7OyBLvAGoLlmF
 2AoiGM5hvbJQ5prGbNqTGe5Lw0chTBwuwEo45T+cMJOI56kMpzg3FiMbRgPnp/Ax0EAPuQu4G
 0Mmpp5DI1KvHtBeflQisGoS9fn4zSabB1+wv+xxBSOMQV6RT20GjfF/6Joz/FjJNcPSSzi4S5
 IwBiFvt8b8nwomZUrYfF2V9YFb9a/BQ2qAJ8S/CSfzr6M2K58lG0eryYCqY/Ehvazh/2YNX9O
 JbmcCHDCMgTmNoDVl0mDr387xC+sxS6YKRIKKfJSsh0MC7nZc2P7t8p8tdIJ2Z/Q84FO+B/Yy
 N0DP+SIOupDLUAgUQTFgezcfXSsCahFEEuOfa4jBiYs8xwBII6O3R2AiwNc2bjGU6CJc3fY53
 V+eJybNP3FaDx7u/2r7XYotiZP5LHr47jPn6VxYyTBmtMXJvkKwz3bGpAjIDroanNklDuNjW1
 J6V7395urq4GZa7/qC7bw5wWyRoc250uv8puvRsVteMiqMQFa22WQnzO4ybDK5BOcqA6LMxF+
 15sGDiWqtNstXASW1kU8VLIE4Ht1I2Jw2ZaPH3drmvOfmhAn25yu2RH8UPEcuqUZI+sURW26Y
 kLsl/Vmt0f/anljKidKOVLEn4FJBR4bf85aKBTRfnBoahsBu9K0po0qrNRHq3F8iAAP9rkqZs
 MqrNwYta5RlWLUfCtI06jIiOGx/GDZMN3oH1oWhG62czaG6z57lpg4t7lWHtoq/las6U1SCvV
 BeSMewvZdUV4R312wYcwwpu1mcGdBlEwFJu19nfNOSjqpeS6y9PqLnYO1cAvGtHpmbQ0EfUrB
 dMdpaArUODoHEaXeq8APs0ITivbXB6Bvg1douCWUg0b6QkWDmYt0nVzpzxwD6W29xuAaTrxvk
 Ywl9lrK1LqZ5p5yo+ol4Vj2vcYru3FbALl+dyjJtzzhKXiZRm6pWKpB2gX7zKwS616aRuHACi
 TvHRCG1ZaHFuIiXVb9NHQU80PQVuieEsSx7aCiAWmbIjeqS0kOJ5vFTj3YQk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 6 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +test_expect_success 'parallel' '
> > +	git remote add one ./bogus1 &&
> > +	git remote add two ./bogus2 &&
> > +
> > +	test_must_fail env GIT_TRACE=3D"$PWD/trace" \
> > +		git fetch --jobs=3D2 --multiple one two 2>err &&
> > +	grep "preparing to run up to 2 tasks" trace &&
> > +	test_i18ngrep "could not fetch .one.*128" err &&
> > +	test_i18ngrep "could not fetch .two.*128" err
> > +'
> > +
> >  test_done
>
> Thanks.  I think it is much better to prepare these tests like this
> patch does to be broken when phrasing changes---that would give
> feedback and confidence to the person who is changing the message
> and/or the logic to emit the message.
>
> Where does the constant 128 come from, by the way?  If it is from errno.=
h
> then we will soon hear breakage report from NonStop folks, I predict
> ;-)

It comes from `die()`:

=2D- snip --
static NORETURN void die_builtin(const char *err, va_list params)
{
        /*
	 * We call this trace2 function first and expect it to va_copy 'params'
	 * before using it (because an 'ap' can only be walked once).
	 */
	trace2_cmd_error_va(err, params);

	vreportf("fatal: ", err, params);

	exit(128);
}
=2D- snap --

Thanks,
Dscho
