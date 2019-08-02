Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A1B1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 03:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfHBDuh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 23:50:37 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:44997 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbfHBDuh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Aug 2019 23:50:37 -0400
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 170E311C1864;
        Fri,  2 Aug 2019 06:50:33 +0300 (MSK)
Received: from unknown (unknown [::1])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id MIJaBmgSM9-oVtqjGtI;
        Fri, 02 Aug 2019 06:50:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1564717832;
        bh=qTTKxrqpLpWWYlyju4+e8cUt8SImjg5aURHz9/e3kmU=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=ZjtmcQRkFId6UOdkTo3nPO9D7IcY7odzZ2YyEOnjKCkWLQGsF3NQmb9hicuk0EmPz
         h3r1yXZjp5x1XtL1khgfCi3hl3k8PNyr5i1vnOOvv0DSGZ4yfUZWbvpb7iy5FH0EG2
         43z67sgk/+TiqGTdirHYU3V17i4dW9fSzs+L/8uY=
Authentication-Results: mxback8o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva4-ba508a90b0c0.qloud-c.yandex.net with HTTP;
        Fri, 02 Aug 2019 06:50:31 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Philip McGraw <philip.mcgraw@bentley.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
In-Reply-To: <BL0PR1901MB2097141B412696422CE957F4FFDE0@BL0PR1901MB2097.namprd19.prod.outlook.com>
References: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <1955471564537683@vla1-53bffb0b04ed.qloud-c.yandex.net>
         <BL0PR1901MB2097EA8851C2743D46210D38FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <2835251564582156@myt6-4218ece6190d.qloud-c.yandex.net>
         <BL0PR1901MB209790A0A8F5F9C8EFB8B3F0FFDF0@BL0PR1901MB2097.namprd19.prod.outlook.com>
         <2717551564623283@vla1-822b1b47a947.qloud-c.yandex.net> <BL0PR1901MB2097141B412696422CE957F4FFDE0@BL0PR1901MB2097.namprd19.prod.outlook.com>
Subject: Re: [PATCH] git-p4: close temporary file before removing
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 01 Aug 2019 23:50:31 -0400
Message-Id: <28612161564717831@iva4-ba508a90b0c0.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



01.08.2019, 11:30, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  From: Andrey <ahippo@yandex.ru>
>>  Sent: Wednesday, 31 July, 2019 21:35
>>  To: Philip McGraw <Philip.McGraw@bentley.com>
>>  Cc: git@vger.kernel.org; luke@diamand.org
>>  Subject: Re: [PATCH] git-p4: close temporary file before removing
>>
>>  31.07.2019, 17:52, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  > 2019.07.31 10:09 Andrey <ahippo@yandex.ru>
>>  >> 31.07.2019, 09:53, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  >>>>   30.07.2019, 13:37, "Philip McGraw" <philip.mcgraw@bentley.com>:
>>  >>>>   > python os.remove() throws exceptions on Windows platform when
>>  attempting
>>  >>>>   > to remove file while it is still open. Need to grab filename
>>  while file open,
>>  >>>>   > close file handle, then remove by name. Apparently other
>>  platforms are more
>>  >>>>   > permissive of removing files while busy.
>>  >>>>   > reference:
>>  >>>>   > ---
>>  >>>>   >  git-p4.py | 4 +++-
>>  >>>>   >  1 file changed, 3 insertions(+), 1 deletion(-)
>>  >>>>   >
>>  >>>>   > diff --git a/git-p4.py b/git-p4.py
>>  >>>>   > index c71a6832e2..6b9d2a8317 100755
>>  >>>>   > --- a/git-p4.py
>>  >>>>   > +++ b/git-p4.py
>>  >>>>   > @@ -1161,12 +1161,14 @@ def exceedsLargeFileThreshold(self,
>>  relPath, contents):
>>  >>>>   >                  return False
>>  >>>>   >              contentTempFile = self.generateTempFile(contents)
>>  >>>>   >              compressedContentFile =
>>  tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
>>  >>>>   > + compressedContentFileName = compressedContentFile.name
>>  >>>>   >              zf = zipfile.ZipFile(compressedContentFile.name,
>>  mode='w')
>>  >>>>   >              zf.write(contentTempFile,
>>  compress_type=zipfile.ZIP_DEFLATED)
>>  >>>>   >              zf.close()
>>  >>>>   >              compressedContentsSize =
>>  zf.infolist()[0].compress_size
>>  >>>>   >              os.remove(contentTempFile)
>>  >>>>   > - os.remove(compressedContentFile.name)
>>  >>>>   > + compressedContentFile.close()
>>  >>>>   > + os.remove(compressedContentFileName)
>>  >>>>
>>  >>>>   I'm not sure why NamedTemporaryFile() is called with delete=False
>>  above,
>>  >>>>   but it appears to me that it can have delete=True instead,
>>  >>>>   so that there is no need to call os.remove() explicitly
>>  >>>>   and thus worry about remove vs close ordering at all.
>>  >>>>
>>  >>>>   >              if compressedContentsSize > gitConfigInt('git-
>>  p4.largeFileCompressedThreshold'):
>>  >>>>   >                  return True
>>  >>>>   >          return False
>>  >>>>   > --
>>  >>>>   > 2.21.0.windows.1
>>  >>>>
>>  >>>>   Thank you,
>>  >>>>   Andrey.
>>  >>>
>>  >>>  Thanks Andrey; simpler is certainly better! I will test and re-submit
>>  v2 of patch with that approach.
>>  >>
>>  >> Thank you, that would be great!
>>  >>
>>  >> --
>>  >> Andrey.
>>  >
>>  > Unfortunately it wasn't as simple it seemed: upon testing with only
>>  changing delete=True,
>>  > found that the problem was not solved. Upon further debugging,
>>  recoded/refactored slightly adding
>>  > allocateTempFileName() locally scoped function to try to clarify how the
>>  NamedTemporaryFile()
>>  > was actually being used.
>>  >
>>  > We can't depend on the delete-on-close because the NamedTemporaryFile()
>>  is merely allocating
>>  > a temporary name for real use by the zipfile open-for-write which fails
>>  (on Windows) if file
>>  > was not explicitly closed first.
>>
>>  Oh, sorry for misguiding you!
>>  I didn't think of this aspect.
>
> No worries! I probably just misunderstood the implementation of your idea.

No, you understood what I was saying correctly.
It's just that I didn't think of opening the file twice.
(or rather that it would be a problem)

>>  > Hopefully the new patch
>>  (https://urldefense.proofpoint.com/v2/url?u=https-
>>  3A__github.com_gitgitgadget_git_pull_301&d=DwIDaQ&c=hmGTLOph1qd_VnCqj81HzE
>>  WkDaxmYdIWRBdoFggzhj8&r=b0ikFMJGw7xxhF3yjexiWJpLuNxlAh1SvUDuUJ-
>>  pHmE&m=1jGOrV_I1Mg5ajkJ7yFEcNlyLnD6zYNXqXB9Z5SIPyE&s=TdT4WHyQCk5WZty_CvajH
>>  XgrZJbmIOl1gbMcngmjmAs&e= ) will make this more clear.
>>
>>  The new changeset looks good to me.
>>  (I'll post a reply in that thread too)
>>
>>  > Open to other suggestions if still not clear.
>>
>>  Just as a thought, ZipFile() can take a file-like object instead of a file
>>  name,
>>  so can be passed the NamedTemporaryFile() object directly instead of its
>>  file name.
>>  This should hopefully avoid double-open issue on Windows.
>
> Another excellent idea that minimizes changes. I am testing this approach
> now and will submit v3 of the patch soon.

Thank you for willing to try the new approach!

>>  However, I'm good with your allocateTempFileName() changeset,
>>  so it's up to you to give it a try or not.
>>
>>  > Thanks again,
>>  > Philip
>>
>>  Thank you,
>>  Andrey.
>
> Thanks,
> Philip

-- 
Andrey.

