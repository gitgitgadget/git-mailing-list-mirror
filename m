Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B2C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F1218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVN/nR+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLRKgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:36:25 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44930 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRKgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 05:36:25 -0500
Received: by mail-ot1-f44.google.com with SMTP id x3so1910537oto.11
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 02:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Lkp86s42rmOiPCS9kQ9JB/c94IBfZayu+g0YEykApZg=;
        b=lVN/nR+6ELPQQKSf/wphi+4TGwF1p9f4AOOyn66txYrv2NZZKI3Ec6EpyMNpqvW8ik
         CpdKljqroshH9cspNW11JloDqaB1+VVTFEG7fIfWT/MR5AdjGLCL/fXHyNCHQY+ve3bc
         55o7AGFfBiGBhtD7tSMTgYq4XnH8s6+/FqEtYXAhVgYYJd9HCYj1ohmlycYANbWIt/Yp
         D6wYAiCy2XwnHM0N++03wYKCvw2+E+JpdO70JCmtYR4YF5Zb3uA7B3jt1unwyjcuSF0q
         UZ3F1ITPlreiFtOn+KgiO2fNs4HOcS3Wkj+9JxfFG5Y9aqr7oLwlqBQ5hcA5yVzOTOrf
         knzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Lkp86s42rmOiPCS9kQ9JB/c94IBfZayu+g0YEykApZg=;
        b=NcpqYB6/DfOPW0GPENBY5XcbSVMkQiZljIctgePZoJZU+7UHQiD0vyX0Iv4ufybZQ8
         fYsTzomD3Aj1wGZEGCkBOHH11sjoD2vml3Dygw8baZMTAi9sw1Ld4WUhi8qbekpg3bGt
         eqXqhbGYnJYqpwse7RZeThAZADQLPLNkScMMH1dG2o3z0BKpEtEeSMmaVoweAvf11J1E
         ujBDSAQgqv59KhOoPXQP5WFL50tT+ua4hP/VsDg/yVIWDpjVGB/L6JBtFeLWw9nOcLDS
         50lAi3Ck1S2e1otyj5g561OL7xO00A7x36F+I86qcL7HzbqeNyWsoMGojxfWxNbWj1xu
         DKWw==
X-Gm-Message-State: APjAAAUR+e4QlF6s67yB9GICx5vexi0OqRQ5KZF7VFMy8WZt5mZboKIo
        gYPOpbc/tZARr0wdjH4i5FoiFH9sQjE=
X-Google-Smtp-Source: APXvYqzfjYSV95ec1os7bVBC+7sCIP7Y84q7TEo+GFakaNXstB9Rua2r0Cxb4E6uyN4T9VEnjY8tzg==
X-Received: by 2002:a05:6830:3013:: with SMTP id a19mr1896431otn.217.1576665381289;
        Wed, 18 Dec 2019 02:36:21 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 17sm642659oty.48.2019.12.18.02.36.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 02:36:20 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Git Test Coverage Report (Dec. 18)
Message-ID: <10fc3a91-5a34-7e47-1b4a-3460f8f9c1a6@gmail.com>
Date:   Wed, 18 Dec 2019 05:36:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is today's test-coverage report.

Thanks,
-Stolee

[1] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-18-commits.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-18.txt
[2] https://derrickstolee.github.io/git-test-coverage/reports/2019-12-18.htm

---

pu	bca46e3060e7375827de0056eab64cad9e556b76
jch	0c7f8a73bddc98b1aeac27d2e8bf3e3109eab9b4
next	64cd5c46229f533beb7b49a8dfd1c5104da25b00
master	b02fd2accad4d48078671adf38fe5b5976d77304
master@{1}	083378cc35c4dbcc607e4cdd24a5fca440163d17


Uncovered code in 'pu' not in 'jch'
--------------------------------------------------------

Commits introducing uncovered code:
Johannes Schindelin	25ea47af built-in add -p: adjust hunk headers as needed
add-interactive.c
25ea47af 29) void init_add_i_state(struct add_i_state *s, struct repository *r)
25ea47af 47) init_color(r, s, "fraginfo", s->fraginfo_color,

add-patch.c
25ea47af 282)  INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
25ea47af 283) }
25ea47af 285) static int parse_range(const char **p,
25ea47af 290) *offset = strtoul(*p, &pend, 10);
25ea47af 291) if (pend == *p)
25ea47af 292) return -1;
25ea47af 293) if (*pend != ',') {
25ea47af 294) *count = 1;
25ea47af 295) *p = pend;
25ea47af 296) return 0;
25ea47af 298) *count = strtoul(pend + 1, (char **)p, 10);
25ea47af 299) return *p == pend + 1 ? -1 : 0;
25ea47af 302) static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
25ea47af 304) struct hunk_header *header = &hunk->header;
25ea47af 305) const char *line = s->plain.buf + hunk->start, *p = line;
25ea47af 306) char *eol = memchr(p, '\n', s->plain.len - hunk->start);
25ea47af 308) if (!eol)
25ea47af 309) eol = s->plain.buf + s->plain.len;
25ea47af 311) if (!skip_prefix(p, "@@ -", &p) ||
25ea47af 312)     parse_range(&p, &header->old_offset, &header->old_count) < 0 ||
25ea47af 313)     !skip_prefix(p, " +", &p) ||
25ea47af 314)     parse_range(&p, &header->new_offset, &header->new_count) < 0 ||
25ea47af 315)     !skip_prefix(p, " @@", &p))
25ea47af 319) hunk->start = eol - s->plain.buf + (*eol == '\n');
25ea47af 320) header->extra_start = p - s->plain.buf;
25ea47af 321) header->extra_end = hunk->start;
25ea47af 323) if (!s->colored.len) {
25ea47af 324) header->colored_extra_start = header->colored_extra_end = 0;
25ea47af 325) return 0;
25ea47af 329) line = s->colored.buf + hunk->colored_start;
25ea47af 330) eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
25ea47af 331) if (!eol)
25ea47af 332) eol = s->colored.buf + s->colored.len;
25ea47af 333) p = memmem(line, eol - line, "@@ -", 4);
25ea47af 334) if (!p)
25ea47af 337) p = memmem(p + 4, eol - p - 4, " @@", 3);
25ea47af 338) if (!p)
25ea47af 341) hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
25ea47af 342) header->colored_extra_start = p + 3 - s->colored.buf;
25ea47af 343) header->colored_extra_end = hunk->colored_start;
25ea47af 345) return 0;
25ea47af 464) return -1;
25ea47af 577) struct hunk_header *header = &hunk->header;
25ea47af 579) if (hunk->header.old_offset != 0 || hunk->header.new_offset != 0) {
25ea47af 586) unsigned long old_offset = header->old_offset;
25ea47af 587) unsigned long new_offset = header->new_offset;
25ea47af 589) if (!colored) {
25ea47af 590) p = s->plain.buf + header->extra_start;
25ea47af 591) len = header->extra_end - header->extra_start;
25ea47af 593) strbuf_addstr(out, s->s.fraginfo_color);
25ea47af 594) p = s->colored.buf + header->colored_extra_start;
25ea47af 595) len = header->colored_extra_end
25ea47af 596) - header->colored_extra_start;
25ea47af 604) strbuf_addf(out, "@@ -%lu,%lu +%lu,%lu @@",
25ea47af 607) if (len)
25ea47af 608) strbuf_add(out, p, len);
25ea47af 609) else if (colored)
25ea47af 610) strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
25ea47af 612) strbuf_addch(out, '\n');
25ea47af 790) ssize_t delta = 0;
25ea47af 799) delta += hunk->header.old_count
25ea47af 800) - hunk->header.new_count;
25ea47af 806) render_hunk(s, hunk, delta, 0, out);
25ea47af 1329) render_hunk(s, hunk, 0, colored, &s->buf);
25ea47af 1552) discard_index(s->s.r->index);
25ea47af 1563) if (!repo_read_index(s->s.r))
25ea47af 1564) repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
25ea47af 1575) struct add_p_state s = {
25ea47af 1580) init_add_i_state(&s.s, r);

Johannes Schindelin	c1f1a9b0 built-in stash: use the built-in `git add -p` if so configured
builtin/stash.c
c1f1a9b0 1026) setenv(INDEX_ENVIRONMENT, old_index_env, 1);

Johannes Schindelin	09032028 legacy stash -p: respect the add.interactive.usebuiltin setting
builtin/add.c
09032028 450) parse_pathspec(&pathspec, 0,
09032028 456) return run_add_interactive(NULL, "--patch=stash", &pathspec);

Johannes Schindelin	1c6d07b9 built-in add -p: implement the "worktree" patch modes
add-patch.c
1c6d07b9 1596) } else if (mode == ADD_P_WORKTREE) {
1c6d07b9 1597) if (!revision)
1c6d07b9 1598) s.mode = &patch_mode_checkout_index;
1c6d07b9 1599) else if (!strcmp(revision, "HEAD"))
1c6d07b9 1600) s.mode = &patch_mode_worktree_head;
1c6d07b9 1602) s.mode = &patch_mode_worktree_nothead;

builtin/add.c
1c6d07b9 213) else if (!strcmp(patch_mode, "--patch=worktree"))
1c6d07b9 214) mode = ADD_P_WORKTREE;

Johannes Schindelin	169205be built-in add -p: implement the "stash" and "reset" patch modes
add-patch.c
169205be 1582) if (mode == ADD_P_STASH)
169205be 1583) s.mode = &patch_mode_stash;
169205be 1584) else if (mode == ADD_P_RESET) {
169205be 1585) if (!revision || !strcmp(revision, "HEAD"))
169205be 1586) s.mode = &patch_mode_reset_head;
169205be 1588) s.mode = &patch_mode_reset_nothead;
169205be 1604) s.mode = &patch_mode_stage;
169205be 1608)     (!s.mode->index_only &&
169205be 1609)      repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
169205be 1610)   NULL, NULL, NULL) < 0) ||

builtin/add.c
169205be 207) else if (!strcmp(patch_mode, "--patch=stash"))
169205be 208) mode = ADD_P_STASH;
169205be 209) else if (!strcmp(patch_mode, "--patch=reset"))
169205be 210) mode = ADD_P_RESET;

Johannes Schindelin	54d9d9b2 built-in add -p: only show the applicable parts of the help text
add-patch.c
54d9d9b2 1516) const char *p = _(help_patch_remainder), *eol = p;
54d9d9b2 1518) color_fprintf(stdout, s->s.help_color, "%s",
54d9d9b2 1525) for (; *p; p = eol + (*eol == '\n')) {
54d9d9b2 1526) eol = strchrnul(p, '\n');
54d9d9b2 1533) if (*p != '?' && !strchr(s->buf.buf, *p))
54d9d9b2 1534) continue;
54d9d9b2 1536) color_fprintf_ln(stdout, s->s.help_color,
54d9d9b2 1537)  "%.*s", (int)(eol - p), p);

Johannes Schindelin	12c24cf8 built-in add -p: color the prompt and the help text
add-patch.c
12c24cf8 1356) color_fprintf(stdout, s->s.prompt_color,
12c24cf8 1360) color_fprintf(stdout, s->s.prompt_color,

Johannes Schindelin	0ecd9d27 built-in add -p: show different prompts for mode changes and deletions
add-patch.c
0ecd9d27 1349) if (file_diff->deleted)
0ecd9d27 1350) prompt_mode_type = PROMPT_DELETION;
0ecd9d27 1351) else if (file_diff->mode_change && !hunk_index)
0ecd9d27 1352) prompt_mode_type = PROMPT_MODE_CHANGE;
0ecd9d27 1354) prompt_mode_type = PROMPT_HUNK;

Johannes Schindelin	d6cf8733 built-in add -p: implement the '/' ("search regex") command
add-patch.c
d6cf8733 1342) strbuf_addstr(&s->buf, ",g,/");
d6cf8733 1452) } else if (s->answer.buf[0] == '/') {
d6cf8733 1456) if (file_diff->hunk_nr < 2) {
d6cf8733 1457) err(s, _("No other hunks to search"));
d6cf8733 1458) continue;
d6cf8733 1460) strbuf_remove(&s->answer, 0, 1);
d6cf8733 1461) strbuf_trim_trailing_newline(&s->answer);
d6cf8733 1462) if (s->answer.len == 0) {
d6cf8733 1463) printf("%s", _("search for regex? "));
d6cf8733 1464) fflush(stdout);
d6cf8733 1465) if (strbuf_getline(&s->answer,
d6cf8733 1467) break;
d6cf8733 1468) strbuf_trim_trailing_newline(&s->answer);
d6cf8733 1469) if (s->answer.len == 0)
d6cf8733 1470) continue;
d6cf8733 1472) ret = regcomp(&regex, s->answer.buf,
d6cf8733 1474) if (ret) {
d6cf8733 1478) err(s, _("Malformed search regexp %s: %s"),
d6cf8733 1480) continue;
d6cf8733 1482) i = hunk_index;
d6cf8733 1485) render_hunk(s, file_diff->hunk + i, 0, 0,
d6cf8733 1487) if (regexec(&regex, s->buf.buf, 0, NULL, 0)
d6cf8733 1489) break;
d6cf8733 1490) i++;
d6cf8733 1491) if (i == file_diff->hunk_nr)
d6cf8733 1492) i = 0;
d6cf8733 1493) if (i != hunk_index)
d6cf8733 1494) continue;
d6cf8733 1495) err(s, _("No hunk matches the given pattern"));
d6cf8733 1496) break;
d6cf8733 1497) }
d6cf8733 1498) hunk_index = i;

Johannes Schindelin	b38dd9e7 strbuf: add a helper function to call the editor "on an strbuf"
strbuf.c
b38dd9e7 1129) int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
b38dd9e7 1132) char *path2 = NULL;
b38dd9e7 1133) int fd, res = 0;
b38dd9e7 1135) if (!is_absolute_path(path))
b38dd9e7 1136) path = path2 = xstrdup(git_path("%s", path));
b38dd9e7 1138) fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
b38dd9e7 1139) if (fd < 0)
b38dd9e7 1140) res = error_errno(_("could not open '%s' for writing"), path);
b38dd9e7 1141) else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
b38dd9e7 1142) res = error_errno(_("could not write to '%s'"), path);
b38dd9e7 1143) close(fd);
b38dd9e7 1144) } else if (close(fd) < 0)
b38dd9e7 1145) res = error_errno(_("could not close '%s'"), path);
b38dd9e7 1147) strbuf_reset(buffer);
b38dd9e7 1148) if (launch_editor(path, buffer, env) < 0)
b38dd9e7 1149) res = error_errno(_("could not edit '%s'"), path);
b38dd9e7 1150) unlink(path);
b38dd9e7 1153) free(path2);
b38dd9e7 1154) return res;

Johannes Schindelin	9254bdfb built-in add -p: implement the 'g' ("goto") command
add-patch.c
9254bdfb 1230) static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
9254bdfb 1233) struct hunk_header *header = &hunk->header;
9254bdfb 1234) struct strbuf *plain = &s->plain;
9254bdfb 1235) size_t len = out->len, i;
9254bdfb 1237) strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
9254bdfb 1240) if (out->len - len < SUMMARY_HEADER_WIDTH)
9254bdfb 1241) strbuf_addchars(out, ' ',
9254bdfb 1242) SUMMARY_HEADER_WIDTH + len - out->len);
9254bdfb 1243) for (i = hunk->start; i < hunk->end; i = find_next_line(plain, i))
9254bdfb 1244) if (plain->buf[i] != ' ')
9254bdfb 1245) break;
9254bdfb 1246) if (i < hunk->end)
9254bdfb 1247) strbuf_add(out, plain->buf + i, find_next_line(plain, i) - i);
9254bdfb 1248) if (out->len - len > SUMMARY_LINE_WIDTH)
9254bdfb 1249) strbuf_setlen(out, len + SUMMARY_LINE_WIDTH);
9254bdfb 1250) strbuf_complete_line(out);
9254bdfb 1251) }
9254bdfb 1254) static size_t display_hunks(struct add_p_state *s,
9254bdfb 1257) size_t end_index = start_index + DISPLAY_HUNKS_LINES;
9254bdfb 1259) if (end_index > file_diff->hunk_nr)
9254bdfb 1260) end_index = file_diff->hunk_nr;
9254bdfb 1262) while (start_index < end_index) {
9254bdfb 1263) struct hunk *hunk = file_diff->hunk + start_index++;
9254bdfb 1265) strbuf_reset(&s->buf);
9254bdfb 1266) strbuf_addf(&s->buf, "%c%2d: ", hunk->use == USE_HUNK ? '+'
9254bdfb 1267)     : hunk->use == SKIP_HUNK ? '-' : ' ',
9254bdfb 1269) summarize_hunk(s, hunk, &s->buf);
9254bdfb 1270) fputs(s->buf.buf, stdout);
9254bdfb 1273) return end_index;
9254bdfb 1341) if (file_diff->hunk_nr > 1)
9254bdfb 1415) } else if (s->answer.buf[0] == 'g') {
9254bdfb 1419) if (file_diff->hunk_nr < 2) {
9254bdfb 1420) err(s, _("No other hunks to goto"));
9254bdfb 1421) continue;
9254bdfb 1423) strbuf_remove(&s->answer, 0, 1);
9254bdfb 1424) strbuf_trim(&s->answer);
9254bdfb 1425) i = hunk_index - DISPLAY_HUNKS_LINES / 2;
9254bdfb 1426) if (i < file_diff->mode_change)
9254bdfb 1427) i = file_diff->mode_change;
9254bdfb 1428) while (s->answer.len == 0) {
9254bdfb 1429) i = display_hunks(s, file_diff, i);
9254bdfb 1430) printf("%s", i < file_diff->hunk_nr ?
9254bdfb 1433) fflush(stdout);
9254bdfb 1434) if (strbuf_getline(&s->answer,
9254bdfb 1436) break;
9254bdfb 1437) strbuf_trim_trailing_newline(&s->answer);
9254bdfb 1440) strbuf_trim(&s->answer);
9254bdfb 1441) response = strtoul(s->answer.buf, &pend, 10);
9254bdfb 1442) if (*pend || pend == s->answer.buf)
9254bdfb 1443) err(s, _("Invalid number: '%s'"),
9254bdfb 1445) else if (0 < response && response <= file_diff->hunk_nr)
9254bdfb 1446) hunk_index = response - 1;
9254bdfb 1448) err(s, Q_("Sorry, only %d hunk available.",
9254bdfb 1451)     (int)file_diff->hunk_nr);

Johannes Schindelin	ae4780e8 built-in add -p: implement the "checkout" patch modes
add-patch.c
ae4780e8 1177) static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
ae4780e8 1180) const char *reverse = is_reverse ? "-R" : NULL;
ae4780e8 1181) struct child_process check_index = CHILD_PROCESS_INIT;
ae4780e8 1182) struct child_process check_worktree = CHILD_PROCESS_INIT;
ae4780e8 1183) struct child_process apply_index = CHILD_PROCESS_INIT;
ae4780e8 1184) struct child_process apply_worktree = CHILD_PROCESS_INIT;
ae4780e8 1187) setup_child_process(s, &check_index,
ae4780e8 1189) applies_index = !pipe_command(&check_index, diff->buf, diff->len,
ae4780e8 1192) setup_child_process(s, &check_worktree,
ae4780e8 1194) applies_worktree = !pipe_command(&check_worktree, diff->buf, diff->len,
ae4780e8 1197) if (applies_worktree && applies_index) {
ae4780e8 1198) setup_child_process(s, &apply_index,
ae4780e8 1200) pipe_command(&apply_index, diff->buf, diff->len,
ae4780e8 1203) setup_child_process(s, &apply_worktree,
ae4780e8 1205) pipe_command(&apply_worktree, diff->buf, diff->len,
ae4780e8 1208) return 1;
ae4780e8 1211) if (!applies_index) {
ae4780e8 1212) err(s, _("The selected hunks do not apply to the index!"));
ae4780e8 1213) if (prompt_yesno(s, _("Apply them to the worktree "
ae4780e8 1215) setup_child_process(s, &apply_worktree,
ae4780e8 1217) return pipe_command(&apply_worktree, diff->buf,
ae4780e8 1220) err(s, _("Nothing was applied.\n"));
ae4780e8 1223) fwrite(diff->buf, diff->len, 1, stderr);
ae4780e8 1225) return 0;
ae4780e8 1553) if (s->mode->apply_for_checkout)
ae4780e8 1554) apply_for_checkout(s, &s->buf,
ae4780e8 1555)    s->mode->is_reverse);
ae4780e8 1557) setup_child_process(s, &cp, "apply", NULL);
ae4780e8 1558) argv_array_pushv(&cp.args, s->mode->apply);
ae4780e8 1559) if (pipe_command(&cp, s->buf.buf, s->buf.len,
ae4780e8 1589) } else if (mode == ADD_P_CHECKOUT) {
ae4780e8 1590) if (!revision)
ae4780e8 1591) s.mode = &patch_mode_checkout_index;
ae4780e8 1592) else if (!strcmp(revision, "HEAD"))
ae4780e8 1593) s.mode = &patch_mode_checkout_head;
ae4780e8 1595) s.mode = &patch_mode_checkout_nothead;

builtin/add.c
ae4780e8 211) else if (!strcmp(patch_mode, "--patch=checkout"))
ae4780e8 212) mode = ADD_P_CHECKOUT;

Johannes Schindelin	ade246ef built-in add -p: implement the 'q' ("quit") command
add-patch.c
ade246ef 1295) int colored = !!s->colored.len, quit = 0;
ade246ef 1385) } else if (ch == 'd' || ch == 'q') {
ade246ef 1391) if (ch == 'q') {
ade246ef 1392) quit = 1;
ade246ef 1393) break;
ade246ef 1569) return quit;

Johannes Schindelin	2e408319 built-in add -p: show helpful hint when nothing can be staged
add-patch.c
2e408319 511) } else if (hunk == &file_diff->head &&
2e408319 512)    starts_with(p, "Binary files "))
2e408319 513) file_diff->binary = 1;
2e408319 1578) size_t i, binary_count = 0;
2e408319 1618) if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
2e408319 1619) binary_count++;
2e408319 1620) else if (patch_update_file(&s, s.file_diff + i))
2e408319 1623) if (s.file_diff_nr == 0)
2e408319 1624) fprintf(stderr, _("No changes.\n"));
2e408319 1625) else if (binary_count == s.file_diff_nr)
2e408319 1626) fprintf(stderr, _("Only binary files changed.\n"));

Johannes Schindelin	bcdd297b built-in add -p: implement hunk editing
add-interactive.c
bcdd297b 49) init_color(r, s, "context", s->context_color,
bcdd297b 51) init_color(r, s, "old", s->file_old_color,
bcdd297b 53) init_color(r, s, "new", s->file_new_color,

add-patch.c
bcdd297b 660) size_t i = *hunk_index, delta;
bcdd297b 665) if (!use_all && hunk->use != USE_HUNK)
bcdd297b 682) if ((!use_all && hunk->use != USE_HUNK) ||
bcdd297b 683)     header->new_offset >= next->new_offset + merged->delta ||
bcdd297b 684)     header->new_offset + header->new_count
bcdd297b 685)     < next->new_offset + merged->delta)
bcdd297b 692) if (merged->start < hunk->start && merged->end > hunk->start) {
bcdd297b 693) merged->end = hunk->end;
bcdd297b 694) merged->colored_end = hunk->colored_end;
bcdd297b 695) delta = 0;
bcdd297b 697) const char *plain = s->plain.buf;
bcdd297b 698) size_t  overlapping_line_count = header->new_offset
bcdd297b 699) + header->new_count - merged->delta
bcdd297b 700) - next->new_offset;
bcdd297b 701) size_t overlap_end = hunk->start;
bcdd297b 702) size_t overlap_start = overlap_end;
bcdd297b 713) for (j = 0; j < overlapping_line_count; j++) {
bcdd297b 714) overlap_next = find_next_line(&s->plain,
bcdd297b 717) if (overlap_next > hunk->end)
bcdd297b 724) if (plain[overlap_end] != ' ')
bcdd297b 732) overlap_start = overlap_end;
bcdd297b 733) overlap_end = overlap_next;
bcdd297b 735) len = overlap_end - overlap_start;
bcdd297b 737) if (len > merged->end - merged->start ||
bcdd297b 738)     memcmp(plain + merged->end - len,
bcdd297b 752) if (merged->end != s->plain.len) {
bcdd297b 753) size_t start = s->plain.len;
bcdd297b 755) strbuf_add(&s->plain, plain + merged->start,
bcdd297b 756)    merged->end - merged->start);
bcdd297b 757) plain = s->plain.buf;
bcdd297b 758) merged->start = start;
bcdd297b 759) merged->end = s->plain.len;
bcdd297b 762) strbuf_add(&s->plain,
bcdd297b 764)    hunk->end - overlap_end);
bcdd297b 765) merged->end = s->plain.len;
bcdd297b 766) merged->splittable_into += hunk->splittable_into;
bcdd297b 767) delta = merged->delta;
bcdd297b 768) merged->delta += hunk->delta;
bcdd297b 773) header->new_count = next->new_offset + delta
bcdd297b 774) + next->new_count - header->new_offset;
bcdd297b 789) size_t save_len = s->plain.len, i;
bcdd297b 798) if (!use_all && hunk->use != USE_HUNK)
bcdd297b 803) if (merge_hunks(s, file_diff, &i, use_all, &merged))
bcdd297b 813) strbuf_setlen(&s->plain, save_len);
bcdd297b 815) delta += hunk->delta;
bcdd297b 979) static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
bcdd297b 981) const char *plain = s->plain.buf;
bcdd297b 984) if (!s->colored.len)
bcdd297b 985) return;
bcdd297b 987) hunk->colored_start = s->colored.len;
bcdd297b 988) for (current = hunk->start; current < hunk->end; ) {
bcdd297b 989) for (eol = current; eol < hunk->end; eol++)
bcdd297b 990) if (plain[eol] == '\n')
bcdd297b 991) break;
bcdd297b 992) next = eol + (eol < hunk->end);
bcdd297b 993) if (eol > current && plain[eol - 1] == '\r')
bcdd297b 994) eol--;
bcdd297b 996) strbuf_addstr(&s->colored,
bcdd297b 997)       plain[current] == '-' ?
bcdd297b 999)       plain[current] == '+' ?
bcdd297b 1002) strbuf_add(&s->colored, plain + current, eol - current);
bcdd297b 1003) strbuf_addstr(&s->colored, GIT_COLOR_RESET);
bcdd297b 1004) if (next > eol)
bcdd297b 1005) strbuf_add(&s->colored, plain + eol, next - eol);
bcdd297b 1006) current = next;
bcdd297b 1008) hunk->colored_end = s->colored.len;
bcdd297b 1011) static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
bcdd297b 1015) strbuf_reset(&s->buf);
bcdd297b 1016) strbuf_commented_addf(&s->buf, _("Manual hunk edit mode -- see bottom for "
bcdd297b 1018) render_hunk(s, hunk, 0, 0, &s->buf);
bcdd297b 1019) strbuf_commented_addf(&s->buf,
bcdd297b 1033) strbuf_commented_addf(&s->buf,
bcdd297b 1040) if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
bcdd297b 1041) return -1;
bcdd297b 1044) hunk->start = s->plain.len;
bcdd297b 1045) for (i = 0; i < s->buf.len; ) {
bcdd297b 1046) size_t next = find_next_line(&s->buf, i);
bcdd297b 1048) if (s->buf.buf[i] != comment_line_char)
bcdd297b 1049) strbuf_add(&s->plain, s->buf.buf + i, next - i);
bcdd297b 1050) i = next;
bcdd297b 1053) hunk->end = s->plain.len;
bcdd297b 1054) if (hunk->end == hunk->start)
bcdd297b 1056) return 0;
bcdd297b 1058) recolor_hunk(s, hunk);
bcdd297b 1065) if (s->plain.buf[hunk->start] == '@' &&
bcdd297b 1066)     parse_hunk_header(s, hunk) < 0)
bcdd297b 1069) return 1;
bcdd297b 1072) static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
bcdd297b 1075) struct hunk_header *header = &hunk->header;
bcdd297b 1078) header->old_count = header->new_count = 0;
bcdd297b 1079) for (i = hunk->start; i < hunk->end; ) {
bcdd297b 1080) switch (s->plain.buf[i]) {
bcdd297b 1082) header->old_count++;
bcdd297b 1083) break;
bcdd297b 1085) header->new_count++;
bcdd297b 1086) break;
bcdd297b 1088) header->old_count++;
bcdd297b 1089) header->new_count++;
bcdd297b 1090) break;
bcdd297b 1093) i = find_next_line(&s->plain, i);
bcdd297b 1096) return orig_old_count - orig_new_count
bcdd297b 1097) - header->old_count + header->new_count;
bcdd297b 1100) static int run_apply_check(struct add_p_state *s,
bcdd297b 1103) struct child_process cp = CHILD_PROCESS_INIT;
bcdd297b 1105) strbuf_reset(&s->buf);
bcdd297b 1106) reassemble_patch(s, file_diff, 1, &s->buf);
bcdd297b 1108) setup_child_process(s, &cp,
bcdd297b 1111) if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
bcdd297b 1114) return 0;
bcdd297b 1117) static int prompt_yesno(struct add_p_state *s, const char *prompt)
bcdd297b 1120) color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
bcdd297b 1121) fflush(stdout);
bcdd297b 1122) if (strbuf_getline(&s->answer, stdin) == EOF)
bcdd297b 1123) return -1;
bcdd297b 1124) strbuf_trim_trailing_newline(&s->answer);
bcdd297b 1125) switch (tolower(s->answer.buf[0])) {
bcdd297b 1126) case 'n': return 0;
bcdd297b 1127) case 'y': return 1;
bcdd297b 1129) }
bcdd297b 1132) static int edit_hunk_loop(struct add_p_state *s,
bcdd297b 1135) size_t plain_len = s->plain.len, colored_len = s->colored.len;
bcdd297b 1138) backup = *hunk;
bcdd297b 1141) int res = edit_hunk_manually(s, hunk);
bcdd297b 1142) if (res == 0) {
bcdd297b 1144) *hunk = backup;
bcdd297b 1145) return -1;
bcdd297b 1148) if (res > 0) {
bcdd297b 1149) hunk->delta +=
bcdd297b 1150) recount_edited_hunk(s, hunk,
bcdd297b 1153) if (!run_apply_check(s, file_diff))
bcdd297b 1154) return 0;
bcdd297b 1158) strbuf_setlen(&s->plain, plain_len);
bcdd297b 1159) strbuf_setlen(&s->colored, colored_len);
bcdd297b 1160) *hunk = backup;
bcdd297b 1169) res = prompt_yesno(s, _("Your edited hunk does not apply. "
bcdd297b 1172) if (res < 1)
bcdd297b 1173) return -1;
bcdd297b 1174) }
bcdd297b 1345) if (hunk_index + 1 > file_diff->mode_change &&
bcdd297b 1346)     !file_diff->deleted)
bcdd297b 1347) strbuf_addstr(&s->buf, ",e");
bcdd297b 1508) } else if (s->answer.buf[0] == 'e') {
bcdd297b 1509) if (hunk_index + 1 == file_diff->mode_change)
bcdd297b 1510) err(s, _("Sorry, cannot edit this hunk"));
bcdd297b 1511) else if (edit_hunk_loop(s, file_diff, hunk) >= 0) {
bcdd297b 1512) hunk->use = USE_HUNK;
bcdd297b 1513) goto soft_increment;
bcdd297b 1550) reassemble_patch(s, file_diff, 0, &s->buf);

Johannes Schindelin	1942ee44 built-in add -i: wire up the new C code for the `patch` command
add-interactive.c
1942ee44 918) struct pathspec ps_selected = { 0 };
1942ee44 924) parse_pathspec(&ps_selected,
1942ee44 929) clear_pathspec(&ps_selected);

Johannes Schindelin	11f2c0da built-in add -p: coalesce hunks after splitting them
add-patch.c
11f2c0da 657) static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
11f2c0da 661) struct hunk *hunk = file_diff->hunk + i;
11f2c0da 663) struct hunk_header *header = &merged->header, *next;
11f2c0da 666) return 0;
11f2c0da 668) *merged = *hunk;
11f2c0da 670) merged->colored_start = merged->colored_end = 0;
11f2c0da 672) for (; i + 1 < file_diff->hunk_nr; i++) {
11f2c0da 673) hunk++;
11f2c0da 674) next = &hunk->header;
11f2c0da 771) header->old_count = next->old_offset + next->old_count
11f2c0da 772) - header->old_offset;
11f2c0da 777) if (i == *hunk_index)
11f2c0da 778) return 0;
11f2c0da 780) *hunk_index = i;
11f2c0da 781) return 1;
11f2c0da 795) struct hunk merged = { 0 };
11f2c0da 804) hunk = &merged;

Johannes Schindelin	7584dd3c built-in add -p: offer a helpful error message when hunk navigation failed
add-patch.c
7584dd3c 257) static void err(struct add_p_state *s, const char *fmt, ...)
7584dd3c 261) va_start(args, fmt);
7584dd3c 262) fputs(s->s.error_color, stderr);
7584dd3c 263) vfprintf(stderr, fmt, args);
7584dd3c 264) fputs(s->s.reset_color, stderr);
7584dd3c 265) fputc('\n', stderr);
7584dd3c 266) va_end(args);
7584dd3c 267) }
7584dd3c 1395) } else if (s->answer.buf[0] == 'K') {
7584dd3c 1396) if (hunk_index)
7584dd3c 1397) hunk_index--;
7584dd3c 1399) err(s, _("No previous hunk"));
7584dd3c 1400) } else if (s->answer.buf[0] == 'J') {
7584dd3c 1402) hunk_index++;
7584dd3c 1404) err(s, _("No next hunk"));
7584dd3c 1405) } else if (s->answer.buf[0] == 'k') {
7584dd3c 1406) if (undecided_previous >= 0)
7584dd3c 1407) hunk_index = undecided_previous;
7584dd3c 1409) err(s, _("No previous hunk"));
7584dd3c 1410) } else if (s->answer.buf[0] == 'j') {
7584dd3c 1411) if (undecided_next >= 0)
7584dd3c 1412) hunk_index = undecided_next;
7584dd3c 1414) err(s, _("No next hunk"));

Johannes Schindelin	f6aa7ecc built-in add -i: start implementing the `patch` functionality in C
add-patch.c
f6aa7ecc 269) static void setup_child_process(struct add_p_state *s,
f6aa7ecc 275) va_start(ap, cp);
f6aa7ecc 276) while ((arg = va_arg(ap, const char *)))
f6aa7ecc 277) argv_array_push(&cp->args, arg);
f6aa7ecc 278) va_end(ap);
f6aa7ecc 280) cp->git_cmd = 1;
f6aa7ecc 281) argv_array_pushf(&cp->env_array,
f6aa7ecc 359) static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
f6aa7ecc 363) struct child_process cp = CHILD_PROCESS_INIT;
f6aa7ecc 367) struct hunk *hunk = NULL;
f6aa7ecc 382) for (i = 0; i < ps->nr; i++)
f6aa7ecc 387) res = capture_command(&cp, plain, 0);
f6aa7ecc 394) return 0;
f6aa7ecc 396) strbuf_complete_line(plain);
f6aa7ecc 416) p = plain->buf;
f6aa7ecc 417) pend = p + plain->len;
f6aa7ecc 418) while (p != pend) {
f6aa7ecc 419) char *eol = memchr(p, '\n', pend - p);
f6aa7ecc 422) if (!eol)
f6aa7ecc 423) eol = pend;
f6aa7ecc 425) if (starts_with(p, "diff ")) {
f6aa7ecc 436) } else if (p == plain->buf)
f6aa7ecc 455) memset(hunk, 0, sizeof(*hunk));
f6aa7ecc 457) hunk->start = p - plain->buf;
f6aa7ecc 525) p = eol == pend ? pend : eol + 1;
f6aa7ecc 526) hunk->end = p - plain->buf;
f6aa7ecc 557) return 0;
f6aa7ecc 574) static void render_hunk(struct add_p_state *s, struct hunk *hunk,
f6aa7ecc 621) }
f6aa7ecc 818) }
f6aa7ecc 1290) size_t hunk_index = 0;
f6aa7ecc 1294) struct child_process cp = CHILD_PROCESS_INIT;
f6aa7ecc 1299) return 0;
f6aa7ecc 1301) strbuf_reset(&s->buf);
f6aa7ecc 1303) fputs(s->buf.buf, stdout);
f6aa7ecc 1306) hunk_index = 0;
f6aa7ecc 1309) undecided_previous = -1;
f6aa7ecc 1310) for (i = hunk_index - 1; i >= 0; i--)
f6aa7ecc 1312) undecided_previous = i;
f6aa7ecc 1313) break;
f6aa7ecc 1316) undecided_next = -1;
f6aa7ecc 1319) undecided_next = i;
f6aa7ecc 1320) break;
f6aa7ecc 1324) if (undecided_previous < 0 && undecided_next < 0 &&
f6aa7ecc 1325)     hunk->use != UNDECIDED_HUNK)
f6aa7ecc 1326) break;
f6aa7ecc 1328) strbuf_reset(&s->buf);
f6aa7ecc 1330) fputs(s->buf.buf, stdout);
f6aa7ecc 1332) strbuf_reset(&s->buf);
f6aa7ecc 1333) if (undecided_previous >= 0)
f6aa7ecc 1334) strbuf_addstr(&s->buf, ",k");
f6aa7ecc 1335) if (hunk_index)
f6aa7ecc 1336) strbuf_addstr(&s->buf, ",K");
f6aa7ecc 1337) if (undecided_next >= 0)
f6aa7ecc 1338) strbuf_addstr(&s->buf, ",j");
f6aa7ecc 1340) strbuf_addstr(&s->buf, ",J");
f6aa7ecc 1363) fflush(stdout);
f6aa7ecc 1364) if (strbuf_getline(&s->answer, stdin) == EOF)
f6aa7ecc 1365) break;
f6aa7ecc 1366) strbuf_trim_trailing_newline(&s->answer);
f6aa7ecc 1368) if (!s->answer.len)
f6aa7ecc 1369) continue;
f6aa7ecc 1370) ch = tolower(s->answer.buf[0]);
f6aa7ecc 1371) if (ch == 'y') {
f6aa7ecc 1372) hunk->use = USE_HUNK;
f6aa7ecc 1374) hunk_index = undecided_next < 0 ?
f6aa7ecc 1376) } else if (ch == 'n') {
f6aa7ecc 1377) hunk->use = SKIP_HUNK;
f6aa7ecc 1378) goto soft_increment;
f6aa7ecc 1379) } else if (ch == 'a') {
f6aa7ecc 1382) if (hunk->use == UNDECIDED_HUNK)
f6aa7ecc 1383) hunk->use = USE_HUNK;
f6aa7ecc 1388) if (hunk->use == UNDECIDED_HUNK)
f6aa7ecc 1389) hunk->use = SKIP_HUNK;
f6aa7ecc 1540) }
f6aa7ecc 1545) break;
f6aa7ecc 1549) strbuf_reset(&s->buf);
f6aa7ecc 1568) putchar('\n');
f6aa7ecc 1607) if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
f6aa7ecc 1611)     parse_diff(&s, ps) < 0) {
f6aa7ecc 1612) strbuf_release(&s.plain);
f6aa7ecc 1614) return -1;
f6aa7ecc 1628) strbuf_release(&s.answer);
f6aa7ecc 1629) strbuf_release(&s.buf);
f6aa7ecc 1630) strbuf_release(&s.plain);
f6aa7ecc 1632) return 0;

builtin/add.c
f6aa7ecc 202) if (!patch_mode)

Johannes Schindelin	572bdc3a built-in add -p: prepare for patch modes other than "stage"
add-interactive.c
572bdc3a 927) res = run_add_p(s->r, ADD_P_STAGE, NULL, &ps_selected);

add-patch.c
572bdc3a 370) argv_array_pushv(&args, s->mode->diff);
572bdc3a 371) if (s->revision) {
572bdc3a 373) argv_array_push(&args,
572bdc3a 375) !strcmp("HEAD", s->revision) &&
572bdc3a 376) get_oid("HEAD", &oid) ?
572bdc3a 379) color_arg_index = args.argc;
572bdc3a 381) argv_array_pushl(&args, "--no-color", "-p", "--", NULL);
572bdc3a 599) if (s->mode->is_reverse)
572bdc3a 600) old_offset -= delta;
572bdc3a 602) new_offset += delta;
572bdc3a 1025)       s->mode->is_reverse ? '+' : '-',
572bdc3a 1026)       s->mode->is_reverse ? '-' : '+',
572bdc3a 1028) strbuf_commented_addf(&s->buf, "%s", _(s->mode->edit_hunk_hint));
572bdc3a 1110) argv_array_pushv(&cp.args, s->mode->apply_check);
572bdc3a 1361)       _(s->mode->prompt_mode[prompt_mode_type]),
572bdc3a 1519)       _(s->mode->help_patch_text));
572bdc3a 1572) int run_add_p(struct repository *r, enum add_p_mode mode,
572bdc3a 1605) s.revision = revision;

builtin/add.c
572bdc3a 205) if (!strcmp(patch_mode, "--patch"))
572bdc3a 206) mode = ADD_P_STAGE;
572bdc3a 218) return !!run_add_p(the_repository, mode, revision, pathspec);

Johannes Schindelin	e3bd11b4 built-in add -p: show colored hunks by default
add-patch.c
e3bd11b4 361) struct argv_array args = ARGV_ARRAY_INIT;
e3bd11b4 362) struct strbuf *plain = &s->plain, *colored = NULL;
e3bd11b4 383) argv_array_push(&args, ps->items[i].original);
e3bd11b4 385) setup_child_process(s, &cp, NULL);
e3bd11b4 386) cp.argv = args.argv;
e3bd11b4 388) if (res) {
e3bd11b4 389) argv_array_clear(&args);
e3bd11b4 392) if (!plain->len) {
e3bd11b4 393) argv_array_clear(&args);
e3bd11b4 398) if (want_color_fd(1, -1)) {
e3bd11b4 399) struct child_process colored_cp = CHILD_PROCESS_INIT;
e3bd11b4 401) setup_child_process(s, &colored_cp, NULL);
e3bd11b4 402) xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
e3bd11b4 403) colored_cp.argv = args.argv;
e3bd11b4 404) colored = &s->colored;
e3bd11b4 405) res = capture_command(&colored_cp, colored, 0);
e3bd11b4 406) argv_array_clear(&args);
e3bd11b4 407) if (res)
e3bd11b4 409) strbuf_complete_line(colored);
e3bd11b4 410) colored_p = colored->buf;
e3bd11b4 411) colored_pend = colored_p + colored->len;
e3bd11b4 413) argv_array_clear(&args);
e3bd11b4 458) if (colored)
e3bd11b4 459) hunk->colored_start = colored_p - colored->buf;
e3bd11b4 528) if (colored) {
e3bd11b4 529) char *colored_eol = memchr(colored_p, '\n',
e3bd11b4 530)    colored_pend - colored_p);
e3bd11b4 531) if (colored_eol)
e3bd11b4 532) colored_p = colored_eol + 1;
e3bd11b4 534) colored_p = colored_pend;
e3bd11b4 536) hunk->colored_end = colored_p - colored->buf;
e3bd11b4 615) if (colored)
e3bd11b4 616) strbuf_add(out, s->colored.buf + hunk->colored_start,
e3bd11b4 617)    hunk->colored_end - hunk->colored_start);
e3bd11b4 619) strbuf_add(out, s->plain.buf + hunk->start,
e3bd11b4 620)    hunk->end - hunk->start);
e3bd11b4 1613) strbuf_release(&s.colored);
e3bd11b4 1631) strbuf_release(&s.colored);

Johannes Schindelin	510aeca1 built-in add -p: implement the hunk splitting feature
add-patch.c
510aeca1 364) char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
510aeca1 435) marker = '\0';
510aeca1 444) if (marker == '-' || marker == '+')
510aeca1 449) hunk->splittable_into++;
510aeca1 470) marker = *p;
510aeca1 520) if ((marker == '-' || marker == '+') && *p == ' ')
510aeca1 521) hunk->splittable_into++;
510aeca1 522) if (marker && *p != '\\')
510aeca1 523) marker = *p;
510aeca1 550) if (marker == '-' || marker == '+')
510aeca1 555) hunk->splittable_into++;
510aeca1 560) static size_t find_next_line(struct strbuf *sb, size_t offset)
510aeca1 564) if (offset >= sb->len)
510aeca1 568) eol = memchr(sb->buf + offset, '\n', sb->len - offset);
510aeca1 569) if (!eol)
510aeca1 570) return sb->len;
510aeca1 571) return eol - sb->buf + 1;
510aeca1 820) static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
510aeca1 823) int colored = !!s->colored.len, first = 1;
510aeca1 824) struct hunk *hunk = file_diff->hunk + hunk_index;
510aeca1 826) size_t end, colored_end, current, colored_current = 0, context_line_count;
510aeca1 830) if (hunk_index >= file_diff->hunk_nr)
510aeca1 834) if (hunk->splittable_into < 2)
510aeca1 835) return 0;
510aeca1 836) splittable_into = hunk->splittable_into;
510aeca1 838) end = hunk->end;
510aeca1 839) colored_end = hunk->colored_end;
510aeca1 841) remaining = hunk->header;
510aeca1 843) file_diff->hunk_nr += splittable_into - 1;
510aeca1 844) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc);
510aeca1 845) if (hunk_index + splittable_into < file_diff->hunk_nr)
510aeca1 846) memmove(file_diff->hunk + hunk_index + splittable_into,
510aeca1 847) file_diff->hunk + hunk_index + 1,
510aeca1 848) (file_diff->hunk_nr - hunk_index - splittable_into)
510aeca1 850) hunk = file_diff->hunk + hunk_index;
510aeca1 851) hunk->splittable_into = 1;
510aeca1 852) memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
510aeca1 854) header = &hunk->header;
510aeca1 855) header->old_count = header->new_count = 0;
510aeca1 857) current = hunk->start;
510aeca1 858) if (colored)
510aeca1 859) colored_current = hunk->colored_start;
510aeca1 860) marker = '\0';
510aeca1 861) context_line_count = 0;
510aeca1 863) while (splittable_into > 1) {
510aeca1 864) ch = s->plain.buf[current];
510aeca1 866) if (!ch)
510aeca1 873) if ((marker == '-' || marker == '+') && ch == ' ') {
510aeca1 874) first = 0;
510aeca1 875) hunk[1].start = current;
510aeca1 876) if (colored)
510aeca1 877) hunk[1].colored_start = colored_current;
510aeca1 878) context_line_count = 0;
510aeca1 888) if (marker != ' ' || (ch != '-' && ch != '+')) {
510aeca1 891) if (ch == '\\')
510aeca1 892) ch = marker ? marker : ' ';
510aeca1 895) if (ch == ' ')
510aeca1 896) context_line_count++;
510aeca1 897) else if (ch == '-')
510aeca1 898) header->old_count++;
510aeca1 899) else if (ch == '+')
510aeca1 900) header->new_count++;
510aeca1 903) marker = ch;
510aeca1 904) current = find_next_line(&s->plain, current);
510aeca1 905) if (colored)
510aeca1 906) colored_current =
510aeca1 907) find_next_line(&s->colored,
510aeca1 909) continue;
510aeca1 919) if (first) {
510aeca1 920) if (header->old_count || header->new_count)
510aeca1 925) header->old_count = context_line_count;
510aeca1 926) header->new_count = context_line_count;
510aeca1 927) context_line_count = 0;
510aeca1 928) first = 0;
510aeca1 929) goto next_hunk_line;
510aeca1 932) remaining.old_offset += header->old_count;
510aeca1 933) remaining.old_count -= header->old_count;
510aeca1 934) remaining.new_offset += header->new_count;
510aeca1 935) remaining.new_count -= header->new_count;
510aeca1 938) hunk[1].header.old_offset =
510aeca1 939) header->old_offset + header->old_count;
510aeca1 940) hunk[1].header.new_offset =
510aeca1 941) header->new_offset + header->new_count;
510aeca1 944) header->old_count += context_line_count;
510aeca1 945) header->new_count += context_line_count;
510aeca1 947) hunk->end = current;
510aeca1 948) if (colored)
510aeca1 949) hunk->colored_end = colored_current;
510aeca1 951) hunk++;
510aeca1 952) hunk->splittable_into = 1;
510aeca1 953) hunk->use = hunk[-1].use;
510aeca1 954) header = &hunk->header;
510aeca1 956) header->old_count = header->new_count = context_line_count;
510aeca1 957) context_line_count = 0;
510aeca1 959) splittable_into--;
510aeca1 960) marker = ch;
510aeca1 964) if (header->old_offset != remaining.old_offset)
510aeca1 967) if (header->new_offset != remaining.new_offset)
510aeca1 970) header->old_count = remaining.old_count;
510aeca1 971) header->new_count = remaining.new_count;
510aeca1 972) hunk->end = end;
510aeca1 973) if (colored)
510aeca1 974) hunk->colored_end = colored_end;
510aeca1 976) return 0;
510aeca1 1343) if (hunk->splittable_into > 1)
510aeca1 1344) strbuf_addstr(&s->buf, ",s");
510aeca1 1499) } else if (s->answer.buf[0] == 's') {
510aeca1 1500) size_t splittable_into = hunk->splittable_into;
510aeca1 1501) if (splittable_into < 2)
510aeca1 1502) err(s, _("Sorry, cannot split this hunk"));
510aeca1 1503) else if (!split_hunk(s, file_diff,
510aeca1 1504)      hunk - file_diff->hunk))
510aeca1 1505) color_fprintf_ln(stdout, s->s.header_color,

Johannes Schindelin	80399aec built-in add -p: support multi-file diffs
add-patch.c
80399aec 365) size_t file_diff_alloc = 0, i, color_arg_index;
80399aec 366) struct file_diff *file_diff = NULL;
80399aec 426) s->file_diff_nr++;
80399aec 427) ALLOC_GROW(s->file_diff, s->file_diff_nr,
80399aec 429) file_diff = s->file_diff + s->file_diff_nr - 1;
80399aec 430) memset(file_diff, 0, sizeof(*file_diff));
80399aec 431) hunk = &file_diff->head;
80399aec 432) hunk->start = p - plain->buf;
80399aec 433) if (colored_p)
80399aec 434) hunk->colored_start = colored_p - colored->buf;
80399aec 451) file_diff->hunk_nr++;
80399aec 452) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
80399aec 454) hunk = file_diff->hunk + file_diff->hunk_nr - 1;
80399aec 784) static void reassemble_patch(struct add_p_state *s,
80399aec 797) hunk = file_diff->hunk + i;
80399aec 1287) static int patch_update_file(struct add_p_state *s,
80399aec 1298) if (!file_diff->hunk_nr)
80399aec 1305) if (hunk_index >= file_diff->hunk_nr)
80399aec 1307) hunk = file_diff->hunk + hunk_index;
80399aec 1311) if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
80399aec 1317) for (i = hunk_index + 1; i < file_diff->hunk_nr; i++)
80399aec 1318) if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
80399aec 1339) if (hunk_index + 1 < file_diff->hunk_nr)
80399aec 1359)       (uintmax_t)file_diff->hunk_nr);
80399aec 1375) file_diff->hunk_nr : undecided_next;
80399aec 1380) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
80399aec 1381) hunk = file_diff->hunk + hunk_index;
80399aec 1386) for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
80399aec 1387) hunk = file_diff->hunk + hunk_index;
80399aec 1401) if (hunk_index + 1 < file_diff->hunk_nr)
80399aec 1543) for (i = 0; i < file_diff->hunk_nr; i++)
80399aec 1544) if (file_diff->hunk[i].use == USE_HUNK)
80399aec 1547) if (i < file_diff->hunk_nr) {
80399aec 1617) for (i = 0; i < s.file_diff_nr; i++)
80399aec 1621) break;

Johannes Schindelin	47dc4fd5 built-in add -p: handle deleted empty files
add-patch.c
47dc4fd5 439) else if (file_diff->deleted)
47dc4fd5 441) else if (starts_with(p, "@@ ") ||
47dc4fd5 442)  (hunk == &file_diff->head &&
47dc4fd5 443)   skip_prefix(p, "deleted file", &deleted))) {
47dc4fd5 461) if (deleted)
47dc4fd5 462) file_diff->deleted = 1;
47dc4fd5 463) else if (parse_hunk_header(s, hunk) < 0)

Johannes Schindelin	5906d5de built-in app -p: allow selecting a mode change as a "hunk"
add-patch.c
5906d5de 348) static int is_octal(const char *p, size_t len)
5906d5de 350) if (!len)
5906d5de 351) return 0;
5906d5de 353) while (len--)
5906d5de 354) if (*p < '0' || *(p++) > '7')
5906d5de 355) return 0;
5906d5de 356) return 1;
5906d5de 420) const char *deleted = NULL, *mode_change = NULL;
5906d5de 471) } else if (hunk == &file_diff->head &&
5906d5de 472)    skip_prefix(p, "old mode ", &mode_change) &&
5906d5de 473)    is_octal(mode_change, eol - mode_change)) {
5906d5de 474) if (file_diff->mode_change)
5906d5de 477) if (file_diff->hunk_nr++)
5906d5de 485) file_diff->mode_change = 1;
5906d5de 486) ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
5906d5de 488) memset(file_diff->hunk, 0, sizeof(struct hunk));
5906d5de 489) file_diff->hunk->start = p - plain->buf;
5906d5de 490) if (colored_p)
5906d5de 491) file_diff->hunk->colored_start =
5906d5de 492) colored_p - colored->buf;
5906d5de 493) } else if (hunk == &file_diff->head &&
5906d5de 494)    skip_prefix(p, "new mode ", &mode_change) &&
5906d5de 495)    is_octal(mode_change, eol - mode_change)) {
5906d5de 501) if (!file_diff->mode_change)
5906d5de 504) if (file_diff->hunk_nr != 1)
5906d5de 507) if (p - plain->buf != file_diff->hunk->end)
5906d5de 515) if (file_diff->deleted && file_diff->mode_change)
5906d5de 539) if (mode_change) {
5906d5de 540) if (file_diff->hunk_nr != 1)
5906d5de 544) file_diff->hunk->end = hunk->end;
5906d5de 545) if (colored)
5906d5de 546) file_diff->hunk->colored_end = hunk->colored_end;
5906d5de 623) static void render_diff_header(struct add_p_state *s,
5906d5de 632) int skip_mode_change =
5906d5de 633) file_diff->mode_change && file_diff->hunk->use != USE_HUNK;
5906d5de 634) struct hunk *head = &file_diff->head, *first = file_diff->hunk;
5906d5de 636) if (!skip_mode_change) {
5906d5de 637) render_hunk(s, head, 0, colored, out);
5906d5de 638) return;
5906d5de 641) if (colored) {
5906d5de 642) const char *p = s->colored.buf;
5906d5de 644) strbuf_add(out, p + head->colored_start,
5906d5de 645)     first->colored_start - head->colored_start);
5906d5de 646) strbuf_add(out, p + first->colored_end,
5906d5de 647)     head->colored_end - first->colored_end);
5906d5de 649) const char *p = s->plain.buf;
5906d5de 651) strbuf_add(out, p + head->start, first->start - head->start);
5906d5de 652) strbuf_add(out, p + first->end, head->end - first->end);
5906d5de 792) render_diff_header(s, file_diff, 0, out);
5906d5de 794) for (i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
5906d5de 1302) render_diff_header(s, file_diff, colored, &s->buf);

Jonathan Nieder	ee70c128 index: offer advice for unknown index extensions
read-cache.c
ee70c128 1756) if (advice_unknown_index_extension) {

Josh Steadmon	6da1f1a9 protocol: advertise multiple supported versions
remote-curl.c
6da1f1a9 354) return 0;

Matheus Tavares	beebb9d2 object-store: allow threaded access to object reading
packfile.c
beebb9d2 1465) return;

sha1-file.c
beebb9d2 1431) return;
beebb9d2 1440) return;

Phillip Wood	430b75f7 commit: give correct advice for empty commit during a rebase
sequencer.c
430b75f7 1583)     return -1;



Uncovered code in 'jch' not in 'next'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	0d50cf5e sequencer: move check_todo_list_from_file() to rebase-interactive.c
rebase-interactive.c
0d50cf5e 210) goto out;
0d50cf5e 215) goto out;
0d50cf5e 224) fprintf(stderr, _(edit_todo_list_advice));

Alex Torok	fed842f0 rebase: fix --fork-point with short refname
builtin/merge-base.c
fed842f0 128) return 1;

Martin Ågren	3bf986d6 builtin/config: collect "value_regexp" data in a struct
builtin/config.c
3bf986d6 329) FREE_AND_NULL(cmd_line_value.regexp);

Martin Ågren	3bcdd852 builtin/config: extract `handle_value_regex()` from `get_value()`
builtin/config.c
3bcdd852 330) return CONFIG_INVALID_PATTERN;
3bcdd852 375) goto free_strings;



Uncovered code in 'next' not in 'master'
--------------------------------------------------------

Commits introducing uncovered code:
Derrick Stolee	d89f09c8 clone: add --sparse mode
builtin/clone.c
d89f09c8 753) result = 1;
d89f09c8 1132) return 1;

Derrick Stolee	e091228e sparse-checkout: update working directory in-process
builtin/sparse-checkout.c
e091228e 85) return 0;

Derrick Stolee	bab3c359 sparse-checkout: create 'init' subcommand
builtin/sparse-checkout.c
bab3c359 221) return 1;
bab3c359 275) return 1;

Derrick Stolee	190a65f9 sparse-checkout: respect core.ignoreCase in cone mode
builtin/sparse-checkout.c
190a65f9 337)    strihash(e->pattern) :

dir.c
190a65f9 669)    strihash(translated->pattern) :
190a65f9 700)    strihash(translated->pattern) :

Derrick Stolee	af09ce24 sparse-checkout: init and set in cone mode
builtin/sparse-checkout.c
af09ce24 352) return;

Derrick Stolee	96cc8ab5 sparse-checkout: use hashmaps for cone patterns
dir.c
96cc8ab5 656) pl->use_cone_patterns = 0;
96cc8ab5 658) goto clear_hashmaps;
96cc8ab5 682) hashmap_add(&pl->parent_hashmap, &translated->ent);
96cc8ab5 683) hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
96cc8ab5 684) free(data);
96cc8ab5 685) return;
96cc8ab5 691) goto clear_hashmaps;
96cc8ab5 709) hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
96cc8ab5 710) free(data);
96cc8ab5 711) free(translated);
96cc8ab5 1273) return MATCHED;

Jeff King	4f0bd8b9 pack-objects: improve partial packfile reuse
builtin/pack-objects.c
4f0bd8b9 1124) return 1;
4f0bd8b9 2681) (reuse_packfile_bitmap &&
4f0bd8b9 2682)  bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));

pack-bitmap.c
4f0bd8b9 808) return;
4f0bd8b9 811) return;
4f0bd8b9 823) return;
4f0bd8b9 861) i = bitmap_git->pack->num_objects / BITS_IN_EWORD;

Jeff King	7cb9754e pack-objects: introduce pack.allowPackReuse
builtin/pack-objects.c
7cb9754e 2834) allow_pack_reuse = git_config_bool(k, v);
7cb9754e 2835) return 0;

Jeff King	7b143c16 pack-bitmap: introduce bitmap_walk_contains()
pack-bitmap.c
7b143c16 903) return 0;

Tanushree Tumane	51a0a4ed bisect--helper: avoid use-after-free
builtin/bisect--helper.c
51a0a4ed 177) return -1;



Uncovered code in 'master' not in 'master@{1}'
--------------------------------------------------------

Commits introducing uncovered code:
Alban Gruin	393adf7a sequencer: directly call pick_commits() from complete_action()
sequencer.c
393adf7a 5272) goto cleanup;

Daniel Ferreira	5e82b9e4 built-in add -i: implement the `status` command
add-interactive.c
5e82b9e4 629) return -1;
5e82b9e4 632) putchar('\n');
5e82b9e4 634) return 0;

Derrick Stolee	44a4693b progress: create GIT_PROGRESS_DELAY
progress.c
44a4693b 308) return start_progress_delay(title, total, get_default_delay(), 1);

Garima Singh	a62f9d1a test-path-utils: offer to run a protectNTFS/protectHFS benchmark
t/helper/test-path-utils.c
a62f9d1a 194) static uint64_t my_random(void)
a62f9d1a 196) my_random_value = my_random_value * 1103515245 + 12345;
a62f9d1a 197) return my_random_value;
a62f9d1a 205) static double my_sqrt(double value)
a62f9d1a 207) const double epsilon = 1e-6;
a62f9d1a 208) double x = value;
a62f9d1a 210) if (value == 0)
a62f9d1a 211) return 0;
a62f9d1a 214) double delta = (value / x - x) / 2;
a62f9d1a 215) if (delta < epsilon && delta > -epsilon)
a62f9d1a 216) return x + delta;
a62f9d1a 217) x += delta;
a62f9d1a 218) }
a62f9d1a 221) static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
a62f9d1a 223) size_t i, j, nr, min_len = 3, max_len = 20;
a62f9d1a 225) int repetitions = 15, file_mode = 0100644;
a62f9d1a 231) if (argc > 1 && !strcmp(argv[1], "--with-symlink-mode")) {
a62f9d1a 232) file_mode = 0120000;
a62f9d1a 233) argc--;
a62f9d1a 234) argv++;
a62f9d1a 237) nr = argc > 1 ? strtoul(argv[1], NULL, 0) : 1000000;
a62f9d1a 238) ALLOC_ARRAY(names, nr);
a62f9d1a 240) if (argc > 2) {
a62f9d1a 241) min_len = strtoul(argv[2], NULL, 0);
a62f9d1a 242) if (argc > 3)
a62f9d1a 243) max_len = strtoul(argv[3], NULL, 0);
a62f9d1a 244) if (min_len > max_len)
a62f9d1a 248) for (i = 0; i < nr; i++) {
a62f9d1a 249) size_t len = min_len + (my_random() % (max_len + 1 - min_len));
a62f9d1a 251) names[i] = xmallocz(len);
a62f9d1a 252) while (len > 0)
a62f9d1a 253) names[i][--len] = (char)(' ' + (my_random() % ('\x7f' - ' ')));
a62f9d1a 256) for (protect_ntfs = 0; protect_ntfs < 2; protect_ntfs++)
a62f9d1a 257) for (protect_hfs = 0; protect_hfs < 2; protect_hfs++) {
a62f9d1a 258) cumul = 0;
a62f9d1a 259) cumul2 = 0;
a62f9d1a 260) for (i = 0; i < repetitions; i++) {
a62f9d1a 261) begin = getnanotime();
a62f9d1a 262) for (j = 0; j < nr; j++)
a62f9d1a 263) verify_path(names[j], file_mode);
a62f9d1a 264) end = getnanotime();
a62f9d1a 265) printf("protect_ntfs = %d, protect_hfs = %d: %lfms\n", protect_ntfs, protect_hfs, (end-begin) / (double)1e6);
a62f9d1a 266) cumul += end - begin;
a62f9d1a 267) cumul2 += (end - begin) * (end - begin);
a62f9d1a 269) m[protect_ntfs][protect_hfs] = cumul / (double)repetitions;
a62f9d1a 270) v[protect_ntfs][protect_hfs] = my_sqrt(cumul2 / (double)repetitions - m[protect_ntfs][protect_hfs] * m[protect_ntfs][protect_hfs]);
a62f9d1a 271) printf("mean: %lfms, stddev: %lfms\n", m[protect_ntfs][protect_hfs] / (double)1e6, v[protect_ntfs][protect_hfs] / (double)1e6);
a62f9d1a 274) for (protect_ntfs = 0; protect_ntfs < 2; protect_ntfs++)
a62f9d1a 275) for (protect_hfs = 0; protect_hfs < 2; protect_hfs++)
a62f9d1a 276) printf("ntfs=%d/hfs=%d: %lf%% slower\n", protect_ntfs, protect_hfs, (m[protect_ntfs][protect_hfs] - m[0][0]) * 100 / m[0][0]);
a62f9d1a 278) return 0;
a62f9d1a 451) if (argc > 1 && !strcmp(argv[1], "protect_ntfs_hfs"))
a62f9d1a 452) return !!protect_ntfs_hfs_benchmark(argc - 1, argv + 1);

Garima Singh	ad155925 tests: add a helper to stress test argument quoting
t/helper/test-run-command.c
ad155925 205) static uint64_t my_random(void)
ad155925 207) uint64_t res = my_random_next;
ad155925 208) my_random_next = my_random_next * 1103515245 + 12345;
ad155925 209) return res;
ad155925 212) static int quote_stress_test(int argc, const char **argv)
ad155925 220) char special[] = ".?*\\^_\"'`{}()[]<>@~&+:;$%"; // \t\r\n\a";
ad155925 222) struct strbuf out = STRBUF_INIT;
ad155925 223) struct argv_array args = ARGV_ARRAY_INIT;
ad155925 224) struct option options[] = {
ad155925 230) const char * const usage[] = {
ad155925 235) argc = parse_options(argc, argv, NULL, options, usage, 0);
ad155925 239) for (i = 0; i < trials; i++) {
ad155925 240) struct child_process cp = CHILD_PROCESS_INIT;
ad155925 242) int ret = 0;
ad155925 244) argv_array_clear(&args);
ad155925 251) arg_offset = args.argc;
ad155925 278) cp.argv = args.argv;
ad155925 279) strbuf_reset(&out);
ad155925 280) if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
ad155925 283) for (j = 0, k = 0; j < arg_count; j++) {
ad155925 284) const char *arg = args.argv[j + arg_offset];
ad155925 286) if (strcmp(arg, out.buf + k))
ad155925 290) k += strlen(out.buf + k) + 1;
ad155925 293) if (k != out.len)
ad155925 297) if (ret) {
ad155925 298) fprintf(stderr, "Trial #%d failed. Arguments:\n", i);
ad155925 299) for (j = 0; j < arg_count; j++)
ad155925 300) fprintf(stderr, "arg #%d: '%s'\n",
ad155925 301) (int)j, args.argv[j + arg_offset]);
ad155925 303) strbuf_release(&out);
ad155925 304) argv_array_clear(&args);
ad155925 306) return ret;
ad155925 309) if (i && (i % 100) == 0)
ad155925 310) fprintf(stderr, "Trials completed: %d\n", (int)i);
ad155925 313) strbuf_release(&out);
ad155925 314) argv_array_clear(&args);
ad155925 316) return 0;
ad155925 319) static int quote_echo(int argc, const char **argv)
ad155925 321) while (argc > 1) {
ad155925 322) fwrite(argv[1], strlen(argv[1]), 1, stdout);
ad155925 323) fputc('\0', stdout);
ad155925 324) argv++;
ad155925 325) argc--;
ad155925 328) return 0;
ad155925 384) return !!quote_stress_test(argc - 1, argv + 1);
ad155925 387) return !!quote_echo(argc - 1, argv + 1);

Hans Jerry Illikainen	72b006f4 gpg-interface: prefer check_signature() for GPG verification
builtin/fmt-merge-msg.c
72b006f4 511) strbuf_addstr(&sig, "gpg verification failed.\n");

gpg-interface.c
72b006f4 223) return error_errno(_("could not create temporary file"));
72b006f4 226) error_errno(_("failed writing detached signature to '%s'"),
72b006f4 228) delete_tempfile(&temp);
72b006f4 229) return -1;
72b006f4 244) gpg_status = &buf;

log-tree.c
72b006f4 461) show_sig_lines(opt, status, "No signature\n");
72b006f4 535) } else if (verify_message.len <= gpg_message_offset)

Jeff King	01968302 fast-import: delay creating leading directories for export-marks
fast-import.c
01968302 1687) failure |= error_errno("unable to create leading directories of %s",
01968302 1689) return;

Johannes Schindelin	55953c77 quote-stress-test: accept arguments to test via the command-line
t/helper/test-run-command.c
55953c77 253) if (argc > 0) {
55953c77 254) trials = 1;
55953c77 255) arg_count = argc;
55953c77 256) for (j = 0; j < arg_count; j++)
55953c77 257) argv_array_push(&args, argv[j]);
55953c77 259) arg_count = 1 + (my_random() % 5);
55953c77 260) for (j = 0; j < arg_count; j++) {
55953c77 262) size_t min_len = 1;
55953c77 263) size_t arg_len = min_len +
55953c77 264) (my_random() % (ARRAY_SIZE(buf) - min_len));
55953c77 266) for (k = 0; k < arg_len; k++)
55953c77 267) buf[k] = special[my_random() %
55953c77 269) buf[arg_len] = '\0';
55953c77 271) argv_array_push(&args, buf);

Johannes Schindelin	14af7ed5 Sync with 2.17.3
t/helper/test-run-command.c
14af7ed5 249) argv_array_pushl(&args, "test-tool", "run-command",

Johannes Schindelin	379e51d1 quote-stress-test: offer to test quoting arguments for MSYS2 sh
t/helper/test-run-command.c
379e51d1 221) int i, j, k, trials = 100, skip = 0, msys2 = 0;
379e51d1 237) setenv("MSYS_NO_PATHCONV", "1", 0);
379e51d1 245) if (msys2)
379e51d1 246) argv_array_pushl(&args, "sh", "-c",

Johannes Schindelin	d2c84dad mingw: refuse to access paths with trailing spaces or periods
t/helper/test-path-utils.c
d2c84dad 454) if (argc > 1 && !strcmp(argv[1], "is_valid_path")) {
d2c84dad 455) int res = 0, expect = 1, i;
d2c84dad 457) for (i = 2; i < argc; i++)
d2c84dad 458) if (!strcmp("--not", argv[i]))
d2c84dad 459) expect = 0;
d2c84dad 460) else if (expect != is_valid_path(argv[i]))
d2c84dad 464) fprintf(stderr,
d2c84dad 466) argv[i], expect ? "" : " not");
d2c84dad 468) return !!res;

Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles are inherited by child processes
t/helper/test-run-command.c
eea4a7f4 331) static int inherit_handle(const char *argv0)
eea4a7f4 333) struct child_process cp = CHILD_PROCESS_INIT;
eea4a7f4 338) xsnprintf(path, sizeof(path), "out-XXXXXX");
eea4a7f4 339) tmp = xmkstemp(path);
eea4a7f4 341) argv_array_pushl(&cp.args,
eea4a7f4 343) cp.in = -1;
eea4a7f4 344) cp.no_stdout = cp.no_stderr = 1;
eea4a7f4 345) if (start_command(&cp) < 0)
eea4a7f4 349) close(tmp);
eea4a7f4 350) if (unlink(path))
eea4a7f4 353) if (close(cp.in) < 0 || finish_command(&cp) < 0)
eea4a7f4 356) return 0;
eea4a7f4 359) static int inherit_handle_child(void)
eea4a7f4 361) struct strbuf buf = STRBUF_INIT;
eea4a7f4 363) if (strbuf_read(&buf, 0, 0) < 0)
eea4a7f4 365) printf("Received %s\n", buf.buf);
eea4a7f4 366) strbuf_release(&buf);
eea4a7f4 368) return 0;
eea4a7f4 379) exit(inherit_handle(argv[0]));
eea4a7f4 381) exit(inherit_handle_child());

Johannes Schindelin	cc756edd unpack-trees: let merged_entry() pass through do_add_entry()'s errors
unpack-trees.c
cc756edd 2067) return -1;

Johannes Schindelin	288a74bc is_ntfs_dotgit(): only verify the leading segment
read-cache.c
288a74bc 1001) if (is_ntfs_dotgitmodules(path))
288a74bc 1002) return 0;

Johannes Schindelin	7530a628 quote-stress-test: allow skipping some trials
t/helper/test-run-command.c
7530a628 275) if (i < skip)
7530a628 276) continue;

Johannes Schindelin	f37c2264 built-in add -i: prepare for multi-selection commands
add-interactive.c
f37c2264 88) FREE_AND_NULL(list->selected);
f37c2264 195) static void list(struct add_i_state *s, struct string_list *list, int *selected,
f37c2264 208) opts->print_item(i, selected ? selected[i] : 0, list->items + i,
f37c2264 249) int singleton = opts->flags & SINGLETON;
f37c2264 250) int immediate = opts->flags & IMMEDIATE;
f37c2264 253) ssize_t res = singleton ? LIST_AND_CHOOSE_ERROR : 0;
f37c2264 255) if (!singleton) {
f37c2264 256) free(items->selected);
f37c2264 257) CALLOC_ARRAY(items->selected, items->items.nr);
f37c2264 260) if (singleton && !immediate)
f37c2264 270) list(s, &items->items, items->selected, &opts->list_opts);
f37c2264 273) fputs(singleton ? "> " : ">> ", stdout);
f37c2264 278) if (immediate)
f37c2264 279) res = LIST_AND_CHOOSE_QUIT;
f37c2264 295) int choose = 1;
f37c2264 297) ssize_t from = -1, to = -1;
f37c2264 307) if (*p == '-') {
f37c2264 308) choose = 0;
f37c2264 309) p++;
f37c2264 310) sep--;
f37c2264 313) if (sep == 1 && *p == '*') {
f37c2264 314) from = 0;
f37c2264 315) to = items->items.nr;
f37c2264 316) } else if (isdigit(*p)) {
f37c2264 327) from = strtoul(p, &endp, 10) - 1;
f37c2264 328) if (endp == p + sep)
f37c2264 329) to = from + 1;
f37c2264 330) else if (*endp == '-') {
f37c2264 331) to = strtoul(++endp, &endp, 10);
f37c2264 333) if (endp != p + sep)
f37c2264 334) from = -1;
f37c2264 340) if (from < 0) {
f37c2264 341) from = find_unique(p, items);
f37c2264 342) if (from >= 0)
f37c2264 343) to = from + 1;
f37c2264 346) if (from < 0 || from >= items->items.nr ||
f37c2264 347)     (singleton && from + 1 != to)) {
f37c2264 350) break;
f37c2264 351) } else if (singleton) {
f37c2264 352) res = from;
f37c2264 356) if (to > items->items.nr)
f37c2264 357) to = items->items.nr;
f37c2264 359) for (; from < to; from++)
f37c2264 360) if (items->selected[from] != choose) {
f37c2264 361) items->selected[from] = choose;
f37c2264 362) res += choose ? +1 : -1;
f37c2264 368) if ((immediate && res != LIST_AND_CHOOSE_ERROR) ||
f37c2264 369)     !strcmp(input.buf, "*"))
f37c2264 588) static void print_file_item(int i, int selected, struct string_list_item *item,
f37c2264 621) printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
f37c2264 1028) static void print_command_item(int i, int selected,

Johannes Schindelin	bdfef049 Sync with 2.16.6
fsck.c
bdfef049 627) if (!S_ISLNK(mode))
bdfef049 628) oidset_insert(&gitmodules_found, oid);

Johannes Schindelin	c08171d1 built-in add -i: allow filtering the modified files list
add-interactive.c
c08171d1 447) if (s->skip_unseen)
c08171d1 448) continue;
c08171d1 460) adddel = s->mode == FROM_INDEX ?
c08171d1 487) static int get_modified_files(struct repository *r,
c08171d1 497) struct collection_status s = { 0 };
c08171d1 508) for (i = 0; i < 2; i++) {
c08171d1 512) if (filter == INDEX_ONLY)
c08171d1 513) s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
c08171d1 515) s.mode = (i == 0) ? FROM_WORKTREE : FROM_INDEX;
c08171d1 516) s.skip_unseen = filter && i;
c08171d1 531) if (s.mode == FROM_INDEX)

Johannes Schindelin	8746e072 built-in add -i: implement the `patch` command
add-interactive.c
8746e072 462) other_adddel = s->mode == FROM_INDEX ?
8746e072 463) &file_item->worktree : &file_item->index;
8746e072 467) if (stat.files[i]->is_binary) {
8746e072 468) if (!other_adddel->binary)
8746e072 469) s->binary_count++;
8746e072 472) if (stat.files[i]->is_unmerged) {
8746e072 473) if (!other_adddel->unmerged)
8746e072 474) s->unmerged_count++;
8746e072 475) adddel->unmerged = 1;
8746e072 542) if (unmerged_count)
8746e072 543) *unmerged_count = s.unmerged_count;
8746e072 544) if (binary_count)
8746e072 545) *binary_count = s.binary_count;
8746e072 628) if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
8746e072 645) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
8746e072 724) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
8746e072 876) static int run_patch(struct add_i_state *s, const struct pathspec *ps,
8746e072 880) int res = 0;
8746e072 882) size_t unmerged_count = 0, binary_count = 0;
8746e072 884) if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
8746e072 886) return -1;
8746e072 888) if (unmerged_count || binary_count) {
8746e072 889) for (i = j = 0; i < files->items.nr; i++) {
8746e072 890) struct file_item *item = files->items.items[i].util;
8746e072 892) if (item->index.binary || item->worktree.binary) {
8746e072 893) free(item);
8746e072 894) free(files->items.items[i].string);
8746e072 895) } else if (item->index.unmerged ||
8746e072 897) color_fprintf_ln(stderr, s->error_color,
8746e072 899)  files->items.items[i].string);
8746e072 900) free(item);
8746e072 901) free(files->items.items[i].string);
8746e072 903) files->items.items[j++] = files->items.items[i];
8746e072 905) files->items.nr = j;
8746e072 908) if (!files->items.nr) {
8746e072 909) if (binary_count)
8746e072 910) fprintf(stderr, _("Only binary files changed.\n"));
8746e072 912) fprintf(stderr, _("No changes.\n"));
8746e072 913) return 0;
8746e072 916) opts->prompt = N_("Patch update");
8746e072 917) count = list_and_choose(s, files, opts);
8746e072 918) if (count >= 0) {
8746e072 919) struct argv_array args = ARGV_ARRAY_INIT;
8746e072 921) argv_array_pushl(&args, "git", "add--interactive", "--patch",
8746e072 923) for (i = 0; i < files->items.nr; i++)
8746e072 924) if (files->selected[i])
8746e072 925) argv_array_push(&args,
8746e072 926) files->items.items[i].string);
8746e072 927) res = run_command_v_opt(args.argv, 0);
8746e072 928) argv_array_clear(&args);
8746e072 931) return res;

Johannes Schindelin	a8c45be9 built-in add -i: implement the `update` command
add-interactive.c
a8c45be9 504) prefix_item_list_clear(files);
a8c45be9 505) s.files = &files->items;
a8c45be9 548) string_list_sort(&files->items);
a8c45be9 593) const char *highlighted = NULL;
a8c45be9 600) if (c->prefix_length > 0 &&
a8c45be9 601)     is_valid_prefix(item->string, c->prefix_length)) {
a8c45be9 602) strbuf_reset(&d->name);
a8c45be9 603) strbuf_addf(&d->name, "%s%.*s%s%s", d->color,
a8c45be9 604)     (int)c->prefix_length, item->string, d->reset,
a8c45be9 605)     item->string + c->prefix_length);
a8c45be9 606) highlighted = d->name.buf;
a8c45be9 618) strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
a8c45be9 631) list(s, &files->items, NULL, &opts->list_opts);
a8c45be9 637) static int run_update(struct add_i_state *s, const struct pathspec *ps,
a8c45be9 641) int res = 0, fd;
a8c45be9 648) if (!files->items.nr) {
a8c45be9 649) putchar('\n');
a8c45be9 650) return 0;
a8c45be9 653) opts->prompt = N_("Update");
a8c45be9 654) count = list_and_choose(s, files, opts);
a8c45be9 655) if (count <= 0) {
a8c45be9 656) putchar('\n');
a8c45be9 657) return 0;
a8c45be9 660) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
a8c45be9 661) if (fd < 0) {
a8c45be9 662) putchar('\n');
a8c45be9 663) return -1;
a8c45be9 666) for (i = 0; i < files->items.nr; i++) {
a8c45be9 667) const char *name = files->items.items[i].string;
a8c45be9 668) if (files->selected[i] &&
a8c45be9 669)     add_file_to_index(s->r->index, name, 0) < 0) {
a8c45be9 671) break;
a8c45be9 675) if (!res && write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
a8c45be9 678) if (!res)
a8c45be9 679) printf(Q_("updated %d path\n",
a8c45be9 682) putchar('\n');
a8c45be9 683) return res;
a8c45be9 995) static void choose_prompt_help(struct add_i_state *s)
a8c45be9 997) color_fprintf_ln(stdout, s->help_color, "%s",
a8c45be9 999) color_fprintf_ln(stdout, s->help_color, "1          - %s",
a8c45be9 1001) color_fprintf_ln(stdout, s->help_color, "3-5        - %s",
a8c45be9 1003) color_fprintf_ln(stdout, s->help_color, "2-3,6-9    - %s",
a8c45be9 1005) color_fprintf_ln(stdout, s->help_color, "foo        - %s",
a8c45be9 1007) color_fprintf_ln(stdout, s->help_color, "-...       - %s",
a8c45be9 1009) color_fprintf_ln(stdout, s->help_color, "*          - %s",
a8c45be9 1011) color_fprintf_ln(stdout, s->help_color, "           - %s",
a8c45be9 1013) }
a8c45be9 1083) struct list_and_choose_options opts = {
a8c45be9 1088) struct prefix_item_list files = PREFIX_ITEM_LIST_INIT;
a8c45be9 1109) print_file_item_data.color = data.color;
a8c45be9 1110) print_file_item_data.reset = data.reset;
a8c45be9 1115) opts.list_opts.header = header.buf;
a8c45be9 1144) prefix_item_list_clear(&files);
a8c45be9 1146) strbuf_release(&print_file_item_data.name);

Johannes Schindelin	0c3944a6 add-interactive: make sure to release `rev.prune_data`
add-interactive.c
0c3944a6 538) if (ps)
0c3944a6 539) clear_pathspec(&rev.prune_data);

Johannes Schindelin	ab1e1ccc built-in add -i: re-implement `add-untracked` in C
add-interactive.c
ab1e1ccc 609) if (d->only_names) {
ab1e1ccc 610) printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
ab1e1ccc 612) return;
ab1e1ccc 794) static int get_untracked_files(struct repository *r,
ab1e1ccc 798) struct dir_struct dir = { 0 };
ab1e1ccc 800) struct strbuf buf = STRBUF_INIT;
ab1e1ccc 802) if (repo_read_index(r) < 0)
ab1e1ccc 805) prefix_item_list_clear(files);
ab1e1ccc 806) setup_standard_excludes(&dir);
ab1e1ccc 807) add_pattern_list(&dir, EXC_CMDL, "--exclude option");
ab1e1ccc 808) fill_directory(&dir, r->index, ps);
ab1e1ccc 810) for (i = 0; i < dir.nr; i++) {
ab1e1ccc 811) struct dir_entry *ent = dir.entries[i];
ab1e1ccc 813) if (index_name_is_other(r->index, ent->name, ent->len)) {
ab1e1ccc 814) strbuf_reset(&buf);
ab1e1ccc 815) strbuf_add(&buf, ent->name, ent->len);
ab1e1ccc 816) add_file_item(&files->items, buf.buf);
ab1e1ccc 820) strbuf_release(&buf);
ab1e1ccc 824) static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
ab1e1ccc 828) struct print_file_item_data *d = opts->list_opts.print_item_data;
ab1e1ccc 829) int res = 0, fd;
ab1e1ccc 833) if (get_untracked_files(s->r, files, ps) < 0)
ab1e1ccc 834) return -1;
ab1e1ccc 836) if (!files->items.nr) {
ab1e1ccc 837) printf(_("No untracked files.\n"));
ab1e1ccc 838) goto finish_add_untracked;
ab1e1ccc 841) opts->prompt = N_("Add untracked");
ab1e1ccc 842) d->only_names = 1;
ab1e1ccc 843) count = list_and_choose(s, files, opts);
ab1e1ccc 844) d->only_names = 0;
ab1e1ccc 845) if (count <= 0)
ab1e1ccc 846) goto finish_add_untracked;
ab1e1ccc 848) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
ab1e1ccc 849) if (fd < 0) {
ab1e1ccc 850) res = -1;
ab1e1ccc 851) goto finish_add_untracked;
ab1e1ccc 854) for (i = 0; i < files->items.nr; i++) {
ab1e1ccc 855) const char *name = files->items.items[i].string;
ab1e1ccc 856) if (files->selected[i] &&
ab1e1ccc 857)     add_file_to_index(s->r->index, name, 0) < 0) {
ab1e1ccc 859) break;
ab1e1ccc 863) if (!res &&
ab1e1ccc 864)     write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
ab1e1ccc 867) if (!res)
ab1e1ccc 868) printf(Q_("added %d path\n",
ab1e1ccc 872) putchar('\n');
ab1e1ccc 873) return res;

Johannes Schindelin	c54ef5e4 built-in add -i: re-implement `revert` in C
add-interactive.c
c54ef5e4 686) static void revert_from_diff(struct diff_queue_struct *q,
c54ef5e4 689) int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
c54ef5e4 691) for (i = 0; i < q->nr; i++) {
c54ef5e4 692) struct diff_filespec *one = q->queue[i]->one;
c54ef5e4 695) if (!(one->mode && !is_null_oid(&one->oid))) {
c54ef5e4 696) remove_file_from_index(opt->repo->index, one->path);
c54ef5e4 697) printf(_("note: %s is untracked now.\n"), one->path);
c54ef5e4 699) ce = make_cache_entry(opt->repo->index, one->mode,
c54ef5e4 700)       &one->oid, one->path, 0, 0);
c54ef5e4 701) if (!ce)
c54ef5e4 704) add_index_entry(opt->repo->index, ce, add_flags);
c54ef5e4 707) }
c54ef5e4 709) static int run_revert(struct add_i_state *s, const struct pathspec *ps,
c54ef5e4 713) int res = 0, fd;
c54ef5e4 717) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
c54ef5e4 722) struct diff_options diffopt = { NULL };
c54ef5e4 725) return -1;
c54ef5e4 727) if (!files->items.nr) {
c54ef5e4 728) putchar('\n');
c54ef5e4 729) return 0;
c54ef5e4 732) opts->prompt = N_("Revert");
c54ef5e4 733) count = list_and_choose(s, files, opts);
c54ef5e4 734) if (count <= 0)
c54ef5e4 735) goto finish_revert;
c54ef5e4 737) fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
c54ef5e4 738) if (fd < 0) {
c54ef5e4 739) res = -1;
c54ef5e4 740) goto finish_revert;
c54ef5e4 743) if (is_initial)
c54ef5e4 744) oidcpy(&oid, s->r->hash_algo->empty_tree);
c54ef5e4 746) tree = parse_tree_indirect(&oid);
c54ef5e4 747) if (!tree) {
c54ef5e4 749) goto finish_revert;
c54ef5e4 751) oidcpy(&oid, &tree->object.oid);
c54ef5e4 754) ALLOC_ARRAY(paths, count + 1);
c54ef5e4 755) for (i = j = 0; i < files->items.nr; i++)
c54ef5e4 756) if (files->selected[i])
c54ef5e4 757) paths[j++] = files->items.items[i].string;
c54ef5e4 758) paths[j] = NULL;
c54ef5e4 760) parse_pathspec(&diffopt.pathspec, 0,
c54ef5e4 764) diffopt.output_format = DIFF_FORMAT_CALLBACK;
c54ef5e4 765) diffopt.format_callback = revert_from_diff;
c54ef5e4 766) diffopt.flags.override_submodule_config = 1;
c54ef5e4 767) diffopt.repo = s->r;
c54ef5e4 769) if (do_diff_cache(&oid, &diffopt))
c54ef5e4 770) res = -1;
c54ef5e4 772) diffcore_std(&diffopt);
c54ef5e4 773) diff_flush(&diffopt);
c54ef5e4 775) free(paths);
c54ef5e4 776) clear_pathspec(&diffopt.pathspec);
c54ef5e4 778) if (!res && write_locked_index(s->r->index, &index_lock,
c54ef5e4 780) res = -1;
c54ef5e4 782) res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
c54ef5e4 785) if (!res)
c54ef5e4 786) printf(Q_("reverted %d path\n",
c54ef5e4 791) return res;

Johannes Schindelin	d7633578 built-in add -i: re-implement the `diff` command
add-interactive.c
d7633578 934) static int run_diff(struct add_i_state *s, const struct pathspec *ps,
d7633578 938) int res = 0;
d7633578 942) int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
d7633578 944) if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
d7633578 945) return -1;
d7633578 947) if (!files->items.nr) {
d7633578 948) putchar('\n');
d7633578 949) return 0;
d7633578 952) opts->prompt = N_("Review diff");
d7633578 953) opts->flags = IMMEDIATE;
d7633578 954) count = list_and_choose(s, files, opts);
d7633578 955) opts->flags = 0;
d7633578 956) if (count >= 0) {
d7633578 957) struct argv_array args = ARGV_ARRAY_INIT;
d7633578 959) argv_array_pushl(&args, "git", "diff", "-p", "--cached",
d7633578 961)     s->r->hash_algo->empty_tree),
d7633578 963) for (i = 0; i < files->items.nr; i++)
d7633578 964) if (files->selected[i])
d7633578 965) argv_array_push(&args,
d7633578 966) files->items.items[i].string);
d7633578 967) res = run_command_v_opt(args.argv, 0);
d7633578 968) argv_array_clear(&args);
d7633578 971) putchar('\n');
d7633578 972) return res;

Johannes Schindelin	b4bbbbd5 apply --allow-overlap: fix a corner case
apply.c
b4bbbbd5 2672) match_beginning = 0;

Johannes Schindelin	2e697ced built-in add -i: offer the `quit` command
add-interactive.c
2e697ced 1129) if (i < 0 || i >= commands.items.nr)
2e697ced 1130) util = NULL;
2e697ced 1132) util = commands.items.items[i].util;
2e697ced 1134) if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
2e697ced 1140) if (util)

Jonathan Nieder	c1547450 submodule: defend against submodule.update = !command in .gitmodules
builtin/submodule--helper.c
c1547450 1501) if (sub->update_strategy.type == SM_UPDATE_COMMAND)

Junio C Hamano	7034cd09 Sync with Git 2.24.1
fsck.c
7034cd09 630) retval += report(options, oid, OBJ_TREE,

René Scharfe	0bb313a5 xdiff: unignore changes in function context
xdiff/xemit.c
0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
0bb313a5 225) xchp = xchp->next;

Rohit Ashiwal	08187b4c rebase -i: support --ignore-date
sequencer.c
08187b4c 903) return NULL;
08187b4c 920) argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
08187b4c 1508) res = -1;
08187b4c 1509) goto out;
08187b4c 2608) opts->allow_ff = 0;
08187b4c 2609) opts->ignore_date = 1;
08187b4c 3639) push_dates(&cmd, opts->committer_date_is_author_date);

Rohit Ashiwal	cbd8db17 rebase -i: support --committer-date-is-author-date
sequencer.c
cbd8db17 890) return NULL;
cbd8db17 989) return -1;
cbd8db17 1428) goto out;
cbd8db17 1432) goto out;
cbd8db17 2603) opts->allow_ff = 0;
cbd8db17 2604) opts->committer_date_is_author_date = 1;

Rohit Ashiwal	c068bcc5 sequencer: allow callers of read_author_script() to ignore fields
sequencer.c
c068bcc5 840) free(kv.items[date_i].util);


