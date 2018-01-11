Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A9C1F404
	for <e@80x24.org>; Thu, 11 Jan 2018 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeAKA3e (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 19:29:34 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:33494 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeAKA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 19:29:34 -0500
Received: by mail-it0-f44.google.com with SMTP id c102so12164458itd.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lji.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M8Q4Qc48978m1npSZqTAKdqQpCBhISvTcYt71OniMGg=;
        b=DoVguvJVrTU+aJixsrWUxTj+xaYIP86vkZX2UB6NGNk6sdw98P22RT9S3N25ZWT16q
         yxVS2Qjpd/wfDOrtCeYqu4CaJxLa4dvE5y6b54LeIvmfCPOp260AK28/DUqLOweuHzaB
         ATVQ8Mr9ob8ndU2T8lBnwDwP82ukeCi+UxDII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M8Q4Qc48978m1npSZqTAKdqQpCBhISvTcYt71OniMGg=;
        b=MVqKzm8mGmHD6SO7Hq8rxMvrtxO7Y4hPgDZoaYYY1bfx71TlXdYwpa8kz7skoOReQ3
         lekIDUTgaMEUOL1NWfF4GBGSMJRcayAx0620JLNFNE+Y8txvZ3iQVBmJFyV0IwuKsXDF
         Pa/X73KTeDfin4jBAj6oJGn6F+WO5CLEcrWpLsPKbvJ8i4biK2Q355OrsMZdcaZj/Tr9
         VSoU5bUSQmcFXqRqnwdpUG6j9KHrdaJyh45vI5LHIPRe9IVLNcm1KKrqsqgHG3B9jmV9
         7NjNhkfRTFVWaFu9j5qkyseUxfk7ZIUwXGUx4NOTb4e/mT8EDe0zjqxIbIbfdu0mfWOC
         CnWA==
X-Gm-Message-State: AKGB3mILqwZmALKVieIvE1+a8hseTN0dqSbs9ndDYjuaMZqzSHl0Au7Z
        I753NMTJmE4j4N2mInLcV5VrP1xOgsUKTCGY9Fg8n/mm6j8=
X-Google-Smtp-Source: ACJfBotsh+0mtxVYsiHxGEyKw9T1W6c7hgHIjJ/DxlbxbkwcRypt9jqBqmxvrcSnjLPpMSwOL4a8BaQ3BWiy3q6DCOk=
X-Received: by 10.36.53.76 with SMTP id k73mr21470847ita.35.1515630573364;
 Wed, 10 Jan 2018 16:29:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.228 with HTTP; Wed, 10 Jan 2018 16:29:12 -0800 (PST)
From:   Jason Greenbaum <jgbaum@lji.org>
Date:   Wed, 10 Jan 2018 16:29:12 -0800
Message-ID: <CAKNOR-JbAjE9URdFw_ZrqVeZot=emHFWLgpjhQ7uqUsJpRzx2A@mail.gmail.com>
Subject: git svn clone of messy repository
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm in the process of using git svn to migrate several repos over to
git and one repo, in particular, has a very challenging format.
During the migration, I would also like to reorganize the repo.  It
looks something like this in svn:

myrepo
  trunk
    project_of_interest
    other_project1
    other_project2
    =E2=80=A6
  branches
    FF-1.0
      project_of_interest
      other_project1
      other_project2
      =E2=80=A6
   FF-1.1
      project_of_interest
      other_project1
      other_project2
      =E2=80=A6

There is also a 'tags' directory at the toplevel, but that's not
important to illustrate the issue I'm having.  What I would like to do
is to migrate ONLY the folder called 'project_of_interest' and
preserve it's trunk, branches, and tags.  I'm not sure this is
possible directly with git svn clone, but here is what I've tried:

git svn clone \
--authors-file=3D$AUTHORS_FILE \
--prefix=3D"" \
--trunk=3Dtrunk/project_of_interest \
--branches=3Dbranches/FF-1.0/project_of_interest \
--branches=3Dbranches/FF-1.1/project_of_interest \
svn://my-svn-server/myrepo \
project_of_interest.git

The trunk seems to become the 'master' branch just fine, but my svn
branches are not pulled down.  I'm not sure I have the syntax right or
if this is even possible without first reorganizing the svn repo in
place, updating the .git/config file, or by some other means.  Any
help would be much appreciated.  I'm happy to provide more info as
needed.

Thanks,

Jason
