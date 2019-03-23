Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3953420248
	for <e@80x24.org>; Sat, 23 Mar 2019 08:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfCWIo6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 04:44:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfCWIo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 04:44:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so4696766wre.10
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKwShtPrwYgA6pzxDlSdn4WZpLpDcAQQoEKrzIDSdpg=;
        b=VAyslB5fY0ZTVLTIQ1ronxCi5WthjwgnmL3q17pqogAQOtTe5WTt6ns5v5VBA8tVGi
         Kh4J7fLBnx5aqZZjYr81u48aExuohuWHx8msBc6JDvqc+f1aOlKgEDyBcaowZvrfJnRT
         s9Omhf6lZYe6brcCb2GEtYBFGJ1404+ipvJZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKwShtPrwYgA6pzxDlSdn4WZpLpDcAQQoEKrzIDSdpg=;
        b=KxR51KV3EPBM03I/3s8r/PAfSM2eBdW7EH/C27+ULhXEEE+pBIE7phma9yv9FhRsO2
         apWs9l0QHZAGhvRlDw38s2cPcDhc5nhZkt2HpI+tEzkoh1Ag4aby5yuLQA2AQ4eppl74
         wp+FGuI4QlNsdkxXuwV5xqydL6ZNGXbsi54eWO40sfmlCaZ+ob3jqWTr+JdEWuRY2d8Y
         6ZC/0QuToqN1I1tcHaMIgFienBZpM8F5gGpSC1CfoX0FW8nnzLoHBJ1dwIV7Ztyt4xMd
         paJ5Od59AfNnXuyyaiDjxNMBzEPYfw4QIe63maaPmR/PqMbZn3dJd4Rjin5OrImYb/ki
         MuVw==
X-Gm-Message-State: APjAAAUJErJ+wDU0mmr0siBYt4ySozEvvsNg+GFZdYm+Tbhtc6yD/Qnm
        zfCG0XDB94PMtso0Nc/hieBsYkaJkyhVV6Rhf2b2fA==
X-Google-Smtp-Source: APXvYqztG0w6CKNtplpfs2C5bWuEybj9q/JxSEykeS5ggr/uc1aYUmg0iagrgOyqcC0ojE1jnFj6c5n7SlXNM70R5Qc=
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr9041244wrn.35.1553330695206;
 Sat, 23 Mar 2019 01:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553283214.git.amazo@checkvideo.com> <bb3e14a3897c98762b0e656d583eaa408a6aba60.1553283214.git.amazo@checkvideo.com>
In-Reply-To: <bb3e14a3897c98762b0e656d583eaa408a6aba60.1553283214.git.amazo@checkvideo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 23 Mar 2019 08:44:44 +0000
Message-ID: <CAE5ih793TVn0NJ54CJTmOZ0Gr2Y4GSYwP-DAyRpjsgJsGc-NrA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] git-p4: support loading changelist descriptions
 from files
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrey <ahippo@yandex.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Mar 2019 at 19:54, Mazo, Andrey <amazo@checkvideo.com> wrote:
>
> Our Perforce server experienced some kind of database corruption a few years ago.
> While the file data and revision history are mostly intact,
> some metadata for several changesets got lost.

I think it's not unheard of for P4 databases to end up being corrupt,
as in your case.

It looks like the RCS files get updated, but the database files (i.e.
the metadata) do not, after which you have a bit of a problem.

So I guess this change could be quite useful, but it really needs some
documentation and tests to support it - git-p4 is already complicated
enough!

Your example script should probably use the same magic that the git-p4
script uses to pick the path to Python.

And perhaps come up with a nicer name than "damaged" - as you say, it
could also be used for other purposes.

> For example, inspecting certain changelists produces errors.
> """
> $ p4 describe -s 12345
> Date 2019/02/26 16:46:17:
> Operation: user-describe
> Operation 'user-describe' failed.
> Change 12345 description missing!
> """
>
> While some metadata (like changeset descriptions) is obviously lost,
> most of it can be reconstructed via other commands:
>  * `p4 changes -l -t //...@12345,12345` --
>    to obtain date+time, author, beginning of changeset description;
>  * `p4 files -a //...@12345,12345` --
>    to obtain file revisions, file types, file actions;
>  * `p4 diff2 -u //...@12344 //...@12345` --
>    to get a unified diff of text files in a changeset;
>  * `p4 print -o binary.blob@12345 //depot/binary.blob@12345` --
>    to get a revision of a binary file.
>
> It might be possible to teach git-p4 to fallback to other methods if `p4 describe` fails,
> but it's probably too special-cased (really depends on kind and scale of DB corruption),
> so some manual intervention is perhaps acceptable.
>
> So, with some manual work, it's possible to reconstruct `p4 -G describe ...` output manually.
> In our case, once git-p4 passes `p4 describe` stage,
> it can proceed further just fine.
> Thus, it's tempting to feed resurrected metadata to git-p4 when a normal `p4 describe` would fail.
>
> This functionality may be useful to cache changelist information,
> or to make some changes to changelist info before feeding it to git-p4.
>
> A new config parameter is introduced to tell git-p4
> to load certain changelist descriptions from files instead of from a server.
> For simplicity, it's one pickled file per changelist.
> ```
> git config --add git-p4.damagedChangelists 12345.pickled
> git config --add git-p4.damagedChangelists 12346.pickled
> ```
>
> The following trivial script may be used to produce pickled `p4 -G describe`-compatible output.
> """
>  #!/usr/bin/python2
>
>  import pickle
>  import time
>
>  # recovered commits of interest
>  changes = [
>      {
>          'change':     '12345',
>          'status':     'submitted',
>          'code':       'stat',
>          'user':       'username1',
>          'time':       str(int(time.mktime(time.strptime('2019/02/28 16:00:30', '%Y/%m/%d %H:%M:%S')))),
>          'client':     'username1_hostname1',
>          'desc':       'A bug is fixed.\nDetails are below:<lost>\n',
>          'depotFile0': '//depot/branch1/foo.sh',
>          'action0':    'edit',
>          'rev0':       '28',
>          'type0':      'xtext',
>          'depotFile1': '//depot/branch1/bar.py',
>          'action1':    'edit',
>          'rev1':       '43',
>          'type1':      'text',
>          'depotFile2': '//depot/branch1/baz.doc',
>          'action2':    'edit',
>          'rev2':       '8',
>          'type2':      'binary',
>          'depotFile3': '//depot/branch1/qqq.c',
>          'action3':    'edit',
>          'rev3':       '6',
>          'type3':      'ktext',
>      },
>  ]
>
>  for change in changes:
>      pickle.dump(change, open('{0}.pickled'.format(change['change']), 'wb'))
> """
>
> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
> ---
>
> Notes:
>     Documentation changes and tests are obviously missing,
>     but I hoped to get some feedback on the idea overall
>     before working on those.
>
>  git-p4.py | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 40bc84573b..3133419280 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -24,10 +24,11 @@
>  import stat
>  import zipfile
>  import zlib
>  import ctypes
>  import errno
> +import pickle
>
>  # support basestring in python3
>  try:
>      unicode = unicode
>  except NameError:
> @@ -2615,10 +2616,12 @@ def __init__(self):
>          self.knownAlienLabelBranches = {}
>
>          self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
>          self.labels = {}
>
> +        self.damagedChangelists = {}
> +
>      # Force a checkpoint in fast-import and wait for it to finish
>      def checkpoint(self):
>          self.gitStream.write("checkpoint\n\n")
>          self.gitStream.write("progress checkpoint\n\n")
>          out = self.gitOutput.readline()
> @@ -3312,10 +3315,25 @@ def getAlienLabelBranchMapping(self):
>          for mapping in alienLabelBranches:
>              if mapping:
>                  (alien, ours) = mapping.split(":")
>                  self.knownAlienLabelBranches[alien] = ours
>
> +    def loadDamagedChangelists(self):
> +        damagedChangelists = gitConfigList("git-p4.damagedChangelists")
> +        for clPickled in damagedChangelists:
> +            if not clPickled:
> +                continue
> +
> +            try:
> +                clDesc = pickle.load(open(clPickled, 'rb'))
> +                if not ("status" in clDesc and "user" in clDesc and "time" in clDesc and "change" in clDesc):
> +                    die("Changelist description read from {0} doesn't have required fields".format(clPickled))
> +            except (IOError, TypeError) as e:
> +                die("Can't read changelist description dict from {0}: {1}".format(clPickled, str(e)))
> +
> +            self.damagedChangelists[int(clDesc["change"])] = clDesc
> +
>      def updateOptionDict(self, d):
>          option_keys = {}
>          if self.keepRepoPath:
>              option_keys['keepRepoPath'] = 1
>
> @@ -3413,11 +3431,14 @@ def searchParent(self, parent, branch, target):
>              return None
>
>      def importChanges(self, changes, origin_revision=0):
>          cnt = 1
>          for change in changes:
> -            description = p4_describe(change)
> +            if change in self.damagedChangelists:
> +                description = self.damagedChangelists[change]
> +            else:
> +                description = p4_describe(change)
>              self.updateOptionDict(description)
>
>              if not self.silent:
>                  sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
>                  sys.stdout.flush()
> @@ -3704,10 +3725,12 @@ def run(self, args):
>                      bad_changesfile = True
>                      break
>          if bad_changesfile:
>              die("Option --changesfile is incompatible with revision specifiers")
>
> +        self.loadDamagedChangelists()
> +
>          newPaths = []
>          for p in self.depotPaths:
>              if p.find("@") != -1:
>                  atIdx = p.index("@")
>                  self.changeRange = p[atIdx:]
> --
> 2.19.2
>
