Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3A1211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAFQjc (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 11:39:32 -0500
Received: from mout.web.de ([212.227.17.12]:37969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfAFQjc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 11:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546792758;
        bh=lZUMWhJI6UbFCnKRrAjn5nn6rrSfMuydix7sRhpDe3w=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=RMO02OeaotZAigY8spZGpqB4BH9ywOOFrSJ/tQPct5Hp+zHZnrw4RfhpWGBkbQsrc
         /RAJ2Cilj2hjTEv356E+bz3OI1oONLxUxe3S1zj+mYJuCOfEJYu/8WJAZGkwg77Ke+
         fkvMo415jsHsLDkuz+wwNs/TjUssg7YI3urRKLzo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUnYm-1gnvEA05Yi-00YBys; Sun, 06
 Jan 2019 17:39:18 +0100
Subject: jk/loose-object-cache
To:     git@vger.kernel.org
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Date:   Sun, 6 Jan 2019 17:39:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ohbpULzx1+6m8Uqf+Btr9z7FYz4Bol8cq5jC24O//koefWeoQsT
 FlzSo/jcFn5Q5ET5Bdwfh1pWIe/upkNho1JW/aGb7FnmSAnQWhrcfEQdDhdlmtuaSWQYTRP
 /tlGRp3g/MsD8Jf8Hj+n1UM6eRayHcCE+Qf+Qu2ZVv+khjhd02AJl4/EK7bu1XJh2q3zW4Q
 p4L0tjJ0LmcVEWyAc0ogw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HLOC5/QxY5E=:tZik1tLUZR9DMTFI0gWXdp
 PxhQeru8hokQhMKY+0iw7Wf9BsQPiOdyxJipJkmve4O7UL8CX5z0xGgOcA7tkwdtPudNMH9k4
 BELLEsj0KCOSSs+WUyXu524V3Jasvs9zWJvLkbMfZYv7KofPTTkFWXvVXYpDgj1zUpmSQUEJK
 1/5gQZF0Obvsa3O3XTI8AMQtEyXiYqocGBT3KP1I55sT8OLupTz8fx0DXkIVNftP+uCE9Yix5
 Fgeoy69H3V1rJwAeUmR1guV0FR8vJZwPkXdK4RijPSZDvT/zMEK43/YPrNj7KbDtAFeBtx8iz
 S4IXeMrcyt0vCsvGzouLc6v2hYAfrdLL9NP4nKk5/XykZucLqmLe/UXYwi05/Z388/3ooKRYy
 /WBRqbtUeXTUs9kXE/Ue4d1kJHeSEZm8n6VtYIK1nFEPPuvnlJ7QONHEBnRpS6dOy99fjpy1V
 h0TQlWvU0WLqsefnQqzr2DzRys5DOixhn8nUJOvRpVhaCsQ9e2I18neW6ua1glgTm1qanRbTK
 dprX9dfZcUCTJPVHJ8EKh8mc5c5JgPqrqnB2s3T3VWv32rdQ8rE311JFdW5mCrSoF0QJ+7FDa
 lFk9ox7M/EyRJOEnEUbAIs6i0FJSToG7rXOyl0yfVIo+m/5KslABx9iL5zMcfIvWo8dXoa1ZH
 a/HqXzK2U2Ku55Vb3nh5HgA2Pake0fpbV/bRqGEa7/MECoWqir3Y4joohDFRFvE7k6bq1ACZK
 GeGdRjpsIMM3L/Tede/uM6M12V1fybhyH8OFgHrEKFBtDaZkV6CrD1dm54nlb0eaHv9hNEs4A
 mSzoqWP4Juuv+9BOJBK6oL3rsc6THaEDHISCWB1DmkjeHf3D3PliEC91rRm6KjcvnjREbNx0f
 WQWM4UaEWPM9t9B1ojjcGFkz1fxU+PBngEOe7t+fWWCYFlwpi+fA+gcBSRL0gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.2018 um 19:04 schrieb Junio C Hamano:
> * jk/loose-object-cache (2018-11-24) 10 commits
>   (merged to 'next' on 2018-12-28 at 5a5faf384e)
>  + odb_load_loose_cache: fix strbuf leak
>  + fetch-pack: drop custom loose object cache
>  + sha1-file: use loose object cache for quick existence check
>  + object-store: provide helpers for loose_objects_cache
>  + sha1-file: use an object_directory for the main object dir
>  + handle alternates paths the same as the main object dir
>  + sha1_file_name(): overwrite buffer instead of appending
>  + rename "alternate_object_database" to "object_directory"
>  + submodule--helper: prefer strip_suffix() to ends_with()
>  + fsck: do not reuse child_process structs
> 
>  Originally merged to 'next' on 2018-11-24
> 
>  Code clean-up with optimization for the codepath that checks
>  (non-)existence of loose objects.
> 
>  Will merge to 'master'.

So this has hit master in the meantime.  We discussed a sort performance
fix in [1]; I'll reply with a short series containing a cleaned-up and
rebased version as a follow-up.

  object-store: factor out odb_loose_cache()
  object-store: factor out odb_clear_loose_cache()
  object-store: use one oid_array per subdirectory for loose cache

 object-store.h | 12 +++++++++++-
 object.c       |  2 +-
 packfile.c     |  7 ++-----
 sha1-file.c    | 24 ++++++++++++++++++++----
 sha1-name.c    | 10 +++++-----
 5 files changed, 39 insertions(+), 16 deletions(-)

[1] https://public-inbox.org/git/221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de/
