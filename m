Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06601FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdDITLa (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34611 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdDITL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so6319196wma.1
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sCFI8NJQtB6G8ZCJoeXtwbMJn5EUrUO+31Z1TpPCCc=;
        b=rHsmSw3Bbas6+fzXswuOOKLr6vGU+zpoy2HNc6KkikodEZTouHCmAwUWaAGoBGh8sn
         9VTc00JAHBUSB79zFfs2AEsXK/f3rrILgHYwtq+IcExIVlXVMrs55HOROKjpP4Tl1euX
         PbpFzX/7Bf++Mh4Vg5jghoYXuCr+hdtePsnQUSVhJXP/UAgiDhnBWLjaHW7Ontflo9Eq
         mbN1HMhyYKs4TFTy1nBXgOtMwU0f3NFHi3B2zVPh4NxK5RSX6m7PG8h/rzmWDI0LobZj
         OjlrS1wjm6O6SJhg1Z6ZC0joYGEXBXJlByNq8hfDdh+vJAF6GHu5WjQPqMzmCfrcauOx
         tmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sCFI8NJQtB6G8ZCJoeXtwbMJn5EUrUO+31Z1TpPCCc=;
        b=H+duLytNuoA4NLD2zUkZgewKXUPXgsdkxltREGVQ3HkKgi9E69m/cTPjC95ymOhVsS
         bFSMbmqQNXoP/+x05hk6FODAcf406wNENqNNGNOg3xfyvDJ983EzsTQ1W3vYz0r4LzZ4
         sMo1CqhZiyaMq3hoN8814TZJJjAycBTNrW18r8QMcEuWZ3JbVdBO3zQ+VGQF1gHeSapk
         A6W5iGEggUyO/lhIA2Nxcn9OGVDlDlI49ASZ92KnO2GLwO04TUlQBg45LmaqkgfgQ6qf
         o5nihb4DldGAeauedeymmoLa5FwPnA3o5TV2hHbsZGQpO8eKnpwQ2gaSUOt/muleJ6rj
         hK/w==
X-Gm-Message-State: AN3rC/6NLWihiFmQFZLnVWftAC73MxkxAKE7wVXXPwhPuOvm44ktvQm4
        lVC1mh+bXbHbAw==
X-Received: by 10.28.169.199 with SMTP id s190mr7131556wme.2.1491765087109;
        Sun, 09 Apr 2017 12:11:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b82sm7363895wmh.4.2017.04.09.12.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Apr 2017 12:11:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] test: Detect *lots* of bugs by adding non-alnum to trash dir names
Date:   Sun,  9 Apr 2017 19:11:15 +0000
Message-Id: <20170409191117.25175-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a patch now on the ML for an issue with read v.s. read -r in
submodule revealed when the submodule name contains a \.

That fix is fine, but we should do better and structurally arrange our
tests to detect these sorts of issues before they're reported.

This series changes the test library so that we interpolate the result
of:

    perl -e 'print join q[], grep { /[^[:alnum:]]/ and !m<[./]> } map chr, 0x01..0x7f'

Into the trash directory name we generate. Doing this makes 30% of the
test suite fail. Most of the diffstat below is just adding:

    test_fails_on_unusual_directory_names=1

To those tests that failed, which makes them not use these garbage
trash directory names.

Some of those failures are legitimate bugs, some are an artifact of us
using shellscripting as our test language (namely interpolating ' and
" somewhere).

It might make sense to mark these tests more granularly, e.g.:

    test_fails_on_unusual_directory_name_types=quotes

etc., if the test fails just because of " or ', but I think as it is
this makes sense for inclusion, it makes sure we don't regress on the
remaining 70% of our test suite.

Ævar Arnfjörð Bjarmason (2):
  tests: mark tests that fail when the TEST_DIRECTORY is unusual
  test-lib: exhaustively insert non-alnum ASCII into the TRASH_DIRECTORY
    name

 t/README                                         | 12 ++++++++++++
 t/t0000-basic.sh                                 |  2 ++
 t/t0003-attributes.sh                            |  1 +
 t/t0021-conversion.sh                            |  1 +
 t/t0060-path-utils.sh                            |  1 +
 t/t0300-credentials.sh                           |  1 +
 t/t0302-credential-store.sh                      |  1 +
 t/t1006-cat-file.sh                              |  1 +
 t/t1013-read-tree-submodule.sh                   |  1 +
 t/t1020-subdirectory.sh                          |  1 +
 t/t1050-large.sh                                 |  1 +
 t/t1060-object-corruption.sh                     |  1 +
 t/t1300-repo-config.sh                           |  1 +
 t/t1305-config-include.sh                        |  1 +
 t/t1308-config-set.sh                            |  1 +
 t/t1309-early-config.sh                          |  1 +
 t/t1500-rev-parse.sh                             |  1 +
 t/t1504-ceiling-dirs.sh                          |  1 +
 t/t1507-rev-parse-upstream.sh                    |  1 +
 t/t1510-repo-setup.sh                            |  1 +
 t/t1515-rev-parse-outside-repo.sh                |  1 +
 t/t2013-checkout-submodule.sh                    |  1 +
 t/t2025-worktree-add.sh                          |  1 +
 t/t2027-worktree-list.sh                         |  1 +
 t/t2028-worktree-move.sh                         |  1 +
 t/t3040-subprojects-basic.sh                     |  1 +
 t/t3050-subprojects-fetch.sh                     |  1 +
 t/t3409-rebase-preserve-merges.sh                |  1 +
 t/t3426-rebase-submodule.sh                      |  1 +
 t/t3501-revert-cherry-pick.sh                    |  1 +
 t/t3512-cherry-pick-submodule.sh                 |  1 +
 t/t3513-revert-submodule.sh                      |  1 +
 t/t3600-rm.sh                                    |  1 +
 t/t3900-i18n-commit.sh                           |  1 +
 t/t3906-stash-submodule.sh                       |  1 +
 t/t4027-diff-submodule.sh                        |  1 +
 t/t4030-diff-textconv.sh                         |  1 +
 t/t4031-diff-rewrite-binary.sh                   |  1 +
 t/t4035-diff-quiet.sh                            |  1 +
 t/t4041-diff-submodule-option.sh                 |  1 +
 t/t4059-diff-submodule-not-initialized.sh        |  1 +
 t/t4060-diff-submodule-option-diff-format.sh     |  1 +
 t/t4137-apply-submodule.sh                       |  1 +
 t/t4203-mailmap.sh                               |  1 +
 t/t4207-log-decoration-colors.sh                 |  1 +
 t/t4255-am-submodule.sh                          |  1 +
 t/t5000-tar-tree.sh                              |  1 +
 t/t5001-archive-attr.sh                          |  1 +
 t/t5002-archive-attr-pattern.sh                  |  1 +
 t/t5003-archive-zip.sh                           |  1 +
 t/t5150-request-pull.sh                          |  1 +
 t/t5300-pack-object.sh                           |  1 +
 t/t5304-prune.sh                                 |  1 +
 t/t5305-include-tag.sh                           |  1 +
 t/t5306-pack-nobase.sh                           |  1 +
 t/t5310-pack-bitmaps.sh                          |  1 +
 t/t5311-pack-bitmaps-shallow.sh                  |  1 +
 t/t5400-send-pack.sh                             |  1 +
 t/t5401-update-hooks.sh                          |  1 +
 t/t5402-post-merge-hook.sh                       |  1 +
 t/t5403-post-checkout-hook.sh                    |  1 +
 t/t5404-tracking-branches.sh                     |  1 +
 t/t5406-remote-rejects.sh                        |  1 +
 t/t5407-post-rewrite-hook.sh                     |  1 +
 t/t5500-fetch-pack.sh                            |  1 +
 t/t5501-fetch-push-alternates.sh                 |  1 +
 t/t5502-quickfetch.sh                            |  1 +
 t/t5505-remote.sh                                |  1 +
 t/t5509-fetch-push-namespaces.sh                 |  1 +
 t/t5510-fetch.sh                                 |  1 +
 t/t5512-ls-remote.sh                             |  1 +
 t/t5514-fetch-multiple.sh                        |  1 +
 t/t5515-fetch-merge-logic.sh                     |  1 +
 t/t5516-fetch-push.sh                            |  1 +
 t/t5519-push-alternates.sh                       |  1 +
 t/t5520-pull.sh                                  |  1 +
 t/t5521-pull-options.sh                          |  1 +
 t/t5522-pull-symlink.sh                          |  1 +
 t/t5524-pull-msg.sh                              |  1 +
 t/t5525-fetch-tagopt.sh                          |  1 +
 t/t5526-fetch-submodules.sh                      |  1 +
 t/t5527-fetch-odd-refs.sh                        |  1 +
 t/t5531-deep-submodule-push.sh                   |  1 +
 t/t5533-push-cas.sh                              |  1 +
 t/t5535-fetch-push-symref.sh                     |  1 +
 t/t5536-fetch-conflicts.sh                       |  1 +
 t/t5537-fetch-shallow.sh                         |  1 +
 t/t5538-push-shallow.sh                          |  1 +
 t/t5539-fetch-http-shallow.sh                    |  1 +
 t/t5540-http-push-webdav.sh                      |  1 +
 t/t5541-http-push-smart.sh                       |  1 +
 t/t5542-push-http-shallow.sh                     |  1 +
 t/t5544-pack-objects-hook.sh                     |  1 +
 t/t5545-push-options.sh                          |  1 +
 t/t5547-push-quarantine.sh                       |  1 +
 t/t5550-http-fetch-dumb.sh                       |  1 +
 t/t5551-http-fetch-smart.sh                      |  1 +
 t/t5560-http-backend-noserver.sh                 |  1 +
 t/t5561-http-backend.sh                          |  1 +
 t/t5570-git-daemon.sh                            |  1 +
 t/t5572-pull-submodule.sh                        |  1 +
 t/t5600-clone-fail-cleanup.sh                    |  1 +
 t/t5601-clone.sh                                 |  1 +
 t/t5604-clone-reference.sh                       |  1 +
 t/t5605-clone-local.sh                           |  1 +
 t/t5606-clone-options.sh                         |  1 +
 t/t5609-clone-branch.sh                          |  1 +
 t/t5610-clone-detached.sh                        |  1 +
 t/t5611-clone-config.sh                          |  1 +
 t/t5612-clone-refspec.sh                         |  1 +
 t/t5613-info-alternate.sh                        |  1 +
 t/t5614-clone-submodules.sh                      |  1 +
 t/t5615-alternate-env.sh                         |  1 +
 t/t5801-remote-helpers.sh                        |  1 +
 t/t5802-connect-helper.sh                        |  1 +
 t/t5810-proto-disable-local.sh                   |  1 +
 t/t5812-proto-disable-http.sh                    |  1 +
 t/t5813-proto-disable-ssh.sh                     |  1 +
 t/t5814-proto-disable-ext.sh                     |  1 +
 t/t5815-submodule-protos.sh                      |  1 +
 t/t5900-repo-selection.sh                        |  1 +
 t/t6008-rev-list-submodule.sh                    |  1 +
 t/t6030-bisect-porcelain.sh                      |  1 +
 t/t6040-tracking-info.sh                         |  1 +
 t/t6041-bisect-submodule.sh                      |  1 +
 t/t6050-replace.sh                               |  1 +
 t/t6060-merge-index.sh                           |  1 +
 t/t6134-pathspec-in-submodule.sh                 |  1 +
 t/t6200-fmt-merge-msg.sh                         |  1 +
 t/t6500-gc.sh                                    |  1 +
 t/t7001-mv.sh                                    |  1 +
 t/t7003-filter-branch.sh                         |  1 +
 t/t7005-editor.sh                                |  1 +
 t/t7006-pager.sh                                 |  1 +
 t/t7008-grep-binary.sh                           |  1 +
 t/t7010-setup.sh                                 |  1 +
 t/t7064-wtstatus-pv2.sh                          |  1 +
 t/t7103-reset-bare.sh                            |  1 +
 t/t7112-reset-submodule.sh                       |  1 +
 t/t7300-clean.sh                                 |  1 +
 t/t7400-submodule-basic.sh                       |  1 +
 t/t7402-submodule-rebase.sh                      |  1 +
 t/t7403-submodule-sync.sh                        |  1 +
 t/t7405-submodule-merge.sh                       |  1 +
 t/t7406-submodule-update.sh                      |  1 +
 t/t7407-submodule-foreach.sh                     |  1 +
 t/t7408-submodule-reference.sh                   |  1 +
 t/t7409-submodule-detached-work-tree.sh          |  1 +
 t/t7410-submodule-checkout-to.sh                 |  1 +
 t/t7411-submodule-config.sh                      |  1 +
 t/t7413-submodule-is-active.sh                   |  1 +
 t/t7504-commit-msg-hook.sh                       |  1 +
 t/t7506-status-submodule.sh                      |  1 +
 t/t7507-commit-verbose.sh                        |  1 +
 t/t7517-per-repo-email.sh                        |  1 +
 t/t7613-merge-submodule.sh                       |  1 +
 t/t7700-repack.sh                                |  1 +
 t/t7800-difftool.sh                              |  1 +
 t/t7810-grep.sh                                  |  1 +
 t/t7814-grep-recurse-submodules.sh               |  1 +
 t/t9001-send-email.sh                            |  1 +
 t/t9020-remote-svn.sh                            |  1 +
 t/t9100-git-svn-basic.sh                         |  1 +
 t/t9101-git-svn-props.sh                         |  1 +
 t/t9102-git-svn-deep-rmdir.sh                    |  1 +
 t/t9103-git-svn-tracked-directory-removed.sh     |  1 +
 t/t9104-git-svn-follow-parent.sh                 |  1 +
 t/t9105-git-svn-commit-diff.sh                   |  1 +
 t/t9106-git-svn-commit-diff-clobber.sh           |  1 +
 t/t9107-git-svn-migrate.sh                       |  1 +
 t/t9108-git-svn-glob.sh                          |  1 +
 t/t9109-git-svn-multi-glob.sh                    |  1 +
 t/t9110-git-svn-use-svm-props.sh                 |  1 +
 t/t9114-git-svn-dcommit-merge.sh                 |  1 +
 t/t9115-git-svn-dcommit-funky-renames.sh         |  1 +
 t/t9116-git-svn-log.sh                           |  1 +
 t/t9117-git-svn-init-clone.sh                    |  1 +
 t/t9118-git-svn-funky-branch-names.sh            |  1 +
 t/t9120-git-svn-clone-with-percent-escapes.sh    |  1 +
 t/t9122-git-svn-author.sh                        |  1 +
 t/t9123-git-svn-rebuild-with-rewriteroot.sh      |  1 +
 t/t9124-git-svn-dcommit-auto-props.sh            |  1 +
 t/t9125-git-svn-multi-glob-branch-names.sh       |  1 +
 t/t9127-git-svn-partial-rebuild.sh               |  1 +
 t/t9128-git-svn-cmd-branch.sh                    |  1 +
 t/t9129-git-svn-i18n-commitencoding.sh           |  1 +
 t/t9131-git-svn-empty-symlink.sh                 |  1 +
 t/t9132-git-svn-broken-symlink.sh                |  1 +
 t/t9133-git-svn-nested-git-repo.sh               |  1 +
 t/t9134-git-svn-ignore-paths.sh                  |  1 +
 t/t9137-git-svn-dcommit-clobber-series.sh        |  1 +
 t/t9138-git-svn-authors-prog.sh                  |  1 +
 t/t9140-git-svn-reset.sh                         |  1 +
 t/t9141-git-svn-multiple-branches.sh             |  1 +
 t/t9142-git-svn-shallow-clone.sh                 |  1 +
 t/t9143-git-svn-gc.sh                            |  1 +
 t/t9144-git-svn-old-rev_map.sh                   |  1 +
 t/t9145-git-svn-master-branch.sh                 |  1 +
 t/t9146-git-svn-empty-dirs.sh                    |  1 +
 t/t9147-git-svn-include-paths.sh                 |  1 +
 t/t9148-git-svn-propset.sh                       |  1 +
 t/t9150-svk-mergetickets.sh                      |  1 +
 t/t9151-svn-mergeinfo.sh                         |  1 +
 t/t9153-git-svn-rewrite-uuid.sh                  |  1 +
 t/t9154-git-svn-fancy-glob.sh                    |  1 +
 t/t9155-git-svn-fetch-deleted-tag.sh             |  1 +
 t/t9156-git-svn-fetch-deleted-tag-2.sh           |  1 +
 t/t9157-git-svn-fetch-merge.sh                   |  1 +
 t/t9158-git-svn-mergeinfo.sh                     |  1 +
 t/t9159-git-svn-no-parent-mergeinfo.sh           |  1 +
 t/t9160-git-svn-preserve-empty-dirs.sh           |  1 +
 t/t9161-git-svn-mergeinfo-push.sh                |  1 +
 t/t9162-git-svn-dcommit-interactive.sh           |  1 +
 t/t9163-git-svn-reset-clears-caches.sh           |  1 +
 t/t9164-git-svn-dcommit-concurrent.sh            |  1 +
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  |  1 +
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |  1 +
 t/t9167-git-svn-cmd-branch-subproject.sh         |  1 +
 t/t9168-git-svn-partially-globbed-names.sh       |  1 +
 t/t9200-git-cvsexportcommit.sh                   |  1 +
 t/t9300-fast-import.sh                           |  1 +
 t/t9350-fast-export.sh                           |  1 +
 t/t9400-git-cvsserver-server.sh                  |  1 +
 t/t9401-git-cvsserver-crlf.sh                    |  1 +
 t/t9402-git-cvsserver-refs.sh                    |  1 +
 t/t9500-gitweb-standalone-no-errors.sh           |  1 +
 t/t9502-gitweb-standalone-parse-output.sh        |  1 +
 t/t9600-cvsimport.sh                             |  1 +
 t/t9601-cvsimport-vendor-branch.sh               |  1 +
 t/t9602-cvsimport-branches-tags.sh               |  1 +
 t/t9604-cvsimport-timestamps.sh                  |  1 +
 t/t9700-perl-git.sh                              |  1 +
 t/t9902-completion.sh                            |  1 +
 t/test-lib.sh                                    |  4 ++++
 234 files changed, 249 insertions(+)

-- 
2.11.0

