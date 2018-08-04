Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62EB1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeHDQZS (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 12:25:18 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40977 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 12:25:18 -0400
Received: by mail-wr1-f45.google.com with SMTP id j5-v6so8043440wrr.8
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fEb+10JBjx5GZPc8N81QLZcCUmJWe2NnlrTOveq/P+8=;
        b=2POIuvBilWsHPNZnXawREzltP3mQf0F46BGfWO6L/33Bl7daZnEL/kFzJqJZ53WoBk
         pxne8Pv8L7xXwjKOuSgIjlkqQNsOBj2BH5b8FM00o4mkFncXFHrMJRCDTTn8iYg90TIH
         xV3oaIQJWEMmRzjZ2rH+Ge/2sMUnVMRp6nxCaa6F601bIg+j96v+DV9QU8QWRBqx0D26
         RT66ql14uCHZC+q7iK0pB6kGq79JeAFvkxTeGDjoZugyRMULRAqyDoWVlpQxU1MwGdhl
         UiOB9FcG2VfVJnrljJZxZEOCEb4ACNcz66NgZrLpLb959uewMROSamT4czAXdjn1rLHE
         lKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEb+10JBjx5GZPc8N81QLZcCUmJWe2NnlrTOveq/P+8=;
        b=fli5/F2CtpK14benbJKOIl/C1lFxth7gw/WlBbqRKKYlwYfGcfL8ay0jYxLz0NDCPo
         qfWaveaLI9sZIwgPBJRvBwrWBN980HOD08pViFtLlzNpvlYZS87ffkrIgUq8ewRlKp9H
         Za3iSCi1Cdmyr6IkoMS+OEEDFuNA0VEMi6dR3A9hbLNYrW19RKlMO1sZ7rjU+layTylO
         /NTVQ2rYiC9YWwBiMoj2zCW7RYnEbvd0yzvrNcP5E3K7KIL3E14PPJiv2FjDaqNqdIi8
         dCKuaOgEYOjbhwdAGBfWGp3B0RqxH9JWAWroo+2p72xA9id/u557cE/Dj3cFXFojPnbg
         6lqw==
X-Gm-Message-State: AOUpUlGP/WSRg7arIEFAeuxLCC/yQ78dw3N9vJ3B40KhWeWCEnMPuoOU
        dFcBF/RqIaITs/Ay2XdbnzjveWy2+SCcaw==
X-Google-Smtp-Source: AAOMgpcw6J/uFPhRMyayM5yAW5d2ByeJt75Q9KOFX3Ppypxc6AxUIZ5AAzVFF3stpSUkbLd0EZaeog==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr5547988wrq.8.1533392664817;
        Sat, 04 Aug 2018 07:24:24 -0700 (PDT)
Received: from 5f28dc333bbd (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id w4-v6sm9832089wrl.46.2018.08.04.07.24.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 07:24:23 -0700 (PDT)
Date:   Sat, 4 Aug 2018 14:24:16 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/1] recover: restoration of deleted worktree files
Message-ID: <20180804142416.GA6@5f28dc333bbd>
References: <20180804142247.GA7@e3c0ce5ceb57>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804142247.GA7@e3c0ce5ceb57>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce git-recover, a simple script to aide in restoration of deleted
worktree files.  This will look for unreachable blobs in the object
database and prompt users to restore them to disk, either interactively
or on the command-line.
---
 git-recover.sh | 311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 311 insertions(+)
 create mode 100755 git-recover.sh

diff --git a/git-recover.sh b/git-recover.sh
new file mode 100755
index 000000000..651d4116f
--- /dev/null
+++ b/git-recover.sh
@@ -0,0 +1,311 @@
+#!/usr/bin/env bash
+#
+# This program helps recover files in your repository that were deleted
+# from the working tree.
+#
+# Copyright (c) 2017-2018 Edward Thomson.
+
+set -e
+
+IFS=$'\n'
+
+PROGNAME=$(echo "$0" | sed -e 's/.*\///')
+GIT_DIR=$(git rev-parse --git-dir)
+
+DO_RECOVER=0
+DO_FULL=0
+DO_INTERACTIVE=0
+BLOBS=()
+FILENAMES=()
+
+function die_usage {
+	echo "usage: $PROGNAME [-a] [-i] [--full] [<id> [-f <filename>] ...]" >&2
+	exit 1
+}
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+	-a|--all)
+		DO_RECOVER=1
+		;;
+	-i|--interactive)
+		DO_INTERACTIVE=1
+		;;
+	--full)
+		DO_FULL=1
+		;;
+	*)
+		if [ "${1:0:1}" == "-" ]; then
+			echo "$PROGNAME: unknown argument: $1" >&2
+			die_usage
+		fi
+		BLOBS+=("$1")
+
+		shift
+		if [ "$1" == "-f" ] || [ "$1" == "--filename" ]; then
+			shift
+			if [ $# == 0 ]; then
+				die_usage
+			fi
+			FILENAMES+=("$1")
+			shift
+		else
+			FILENAMES+=("")
+		fi
+		continue
+	;;
+	esac
+	shift
+done
+
+if [ ${#BLOBS[@]} != 0 ] && [ $DO_RECOVER == 1 ]; then
+	die_usage
+elif [ ${#BLOBS[@]} != 0 ]; then
+	DO_RECOVER=1
+fi
+
+case "$OSTYPE" in
+	darwin*|freebsd*) IS_BSD=1 ;;
+	*) IS_BSD=0 ;;
+esac
+
+function expand_given_blobs() {
+	for i in "${!BLOBS[@]}"; do
+		ID=$(git rev-parse --verify "${BLOBS[$i]}" 2>/dev/null || true)
+
+		if [ -z "$ID" ]; then
+			echo "$PROGNAME: ${BLOBS[$i]} is not a valid object." 1>&2
+			exit 1
+		fi
+
+		TYPE=$(git cat-file -t "${ID}" 2>/dev/null || true)
+
+		if [ "$TYPE" != "blob" ]; then
+			echo "$PROGNAME: ${BLOBS[$i]} is not a blob." 1>&2
+			exit
+		fi
+
+		BLOBS[$i]=$ID
+	done
+}
+
+# find all the unreachable blobs
+function find_unreachable() {
+	FULLNESS="--no-full"
+
+	if [ $DO_FULL == 1 ]; then FULLNESS="--full"; fi
+
+	BLOBS=($(git fsck --unreachable --no-reflogs \
+		"${FULLNESS}" --no-progress | sed -ne 's/^unreachable blob //p'))
+}
+
+function read_one_file {
+	BLOB=$1
+	FILTER_NAME=$2
+	ARGS=()
+
+	if [ -z "$FILTER_NAME" ]; then
+		ARGS+=("blob")
+	else
+		ARGS+=("--filters" "--path=$FILTER_NAME")
+	fi
+
+	git cat-file "${ARGS[@]}" "$BLOB"
+}
+
+function write_one_file {
+	BLOB=$1
+	FILTER_NAME=$2
+	OUTPUT_NAME=$3
+
+	ABBREV=$(git rev-parse --short "${BLOB}")
+
+	echo -n "Writing $ABBREV: "
+	read_one_file "$BLOB" "$FILTER_NAME" > "$OUTPUT_NAME"
+	echo "$OUTPUT_NAME."
+}
+
+function unique_filename {
+	if [ ! -f "${BLOB}" ]; then
+		echo "$BLOB"
+	else
+		cnt=1
+		while true
+		do
+			fn="${BLOB}~${cnt}"
+			if [ ! -f "${fn}" ]; then
+				echo "${fn}"
+				break
+			fi
+			cnt=$((cnt+1))
+		done
+	fi
+}
+
+function write_recoverable {
+	for i in "${!BLOBS[@]}"; do
+		BLOB=${BLOBS[$i]}
+		FILTER_NAME=${FILENAMES[$i]}
+		OUTPUT_NAME=${FILENAMES[$i]:-$(unique_filename)}
+
+		write_one_file "$BLOB" "$FILTER_NAME" "$OUTPUT_NAME"
+	done
+}
+
+function file_time {
+	if [ $IS_BSD == 1 ]; then
+		stat -f %c "$1"
+	else
+		stat -c %Y "$1"
+	fi
+}
+
+function timestamp_to_s {
+	if [ $IS_BSD == 1 ]; then
+		date -r "$1"
+	else
+		date -d @"$1"
+	fi
+}
+
+function sort_by_timestamp {
+	# sort blobs in loose objects by their timestamp (packed blobs last)
+	BLOB_AND_TIMESTAMPS=($(for BLOB in "${BLOBS[@]}"; do
+		LOOSE="${BLOB::2}/${BLOB:2}"
+		TIME=$(file_time "$GIT_DIR/objects/$LOOSE" 2>/dev/null || true)
+		echo "$BLOB $TIME"
+	done | sort -k2 -r))
+}
+
+function print_recoverable {
+	echo "Recoverable orphaned git blobs:"
+	echo ""
+
+	sort_by_timestamp
+	for BLOB_AND_TIMESTAMP in "${BLOB_AND_TIMESTAMPS[@]}"; do
+		BLOB=${BLOB_AND_TIMESTAMP::40}
+		TIME=${BLOB_AND_TIMESTAMP:41}
+		DATE=$([ ! -z "$TIME" ] && timestamp_to_s "$TIME" || echo "(Unknown)") 
+
+		echo "$BLOB  $DATE"
+	done
+}
+
+function prompt_for_filename {
+	while true
+	do
+		echo -n "Filename (return to skip): "
+		read -r FILENAME
+
+		if [ -f "$FILENAME" ]; then
+			echo -n "File exists, overwrite? [y,N]: "
+			read -r overwrite
+
+			case "$overwrite" in
+			[yY]*)
+				return 0
+				;;
+			esac
+
+			echo
+		else
+			return 0
+		fi
+	done
+}
+
+function view_file {
+	read_one_file "${BLOB}" | ${PAGER:-less}
+}
+
+function show_summary {
+	FILETYPE=$(read_one_file "${BLOB}" | file -b -)
+	IS_TEXT=$(echo "${FILETYPE}" | grep -c ' text$' 2>/dev/null || true)
+
+	if [ "$IS_TEXT" == "1" ]; then
+		read_one_file "${BLOB}"
+	else
+		read_one_file "${BLOB}" | hexdump -C
+	fi
+}
+
+function interactive {
+	echo "Recoverable orphaned git blobs:"
+
+	sort_by_timestamp
+	for BLOB_AND_TIMESTAMP in "${BLOB_AND_TIMESTAMPS[@]}"; do
+		echo
+
+		BLOB=${BLOB_AND_TIMESTAMP::40}
+		TIME=${BLOB_AND_TIMESTAMP:41}
+		DATE=$([ ! -z "$TIME" ] && timestamp_to_s "$TIME" || echo "(Unknown)") 
+
+		echo "$BLOB  ($DATE)"
+		show_summary "${BLOB}" | head -4 | sed -e 's/^/> /'
+		echo
+
+		while true
+		do
+			echo -n "Recover this file? [y,n,v,f,q,?]: "
+			read -r ans || return 1
+
+			case "$ans" in
+			[yY]*)
+				write_one_file "${BLOB}" "" "$(unique_filename)"
+				break
+				;;
+			[nN]*)
+				break
+				;;
+			[vV]*)
+				view_file "${BLOB}"
+				echo
+				;;
+			[fF]*)
+				prompt_for_filename
+
+				if [ "$FILENAME" == "" ]; then
+					break
+				fi
+
+				write_one_file "${BLOB}" "${FILENAME}" "${FILENAME}"
+				break
+				;;
+			\?*)
+				echo
+				echo "Do you want to recover this file?"
+				echo " y: yes, write the file to ${BLOB}"
+				echo " n: no, skip this file and see the next orphaned file"
+				echo " v: view the file"
+				echo " f: prompt for a filename to use for recovery"
+				echo " q: quit"
+				echo
+				;;
+			[qQ]*)
+				return 0
+				;;
+			esac
+		done
+	done
+}
+
+
+if [ ${#BLOBS[@]} != 0 ]; then
+	expand_given_blobs
+else
+	find_unreachable
+fi
+
+if [ ${#BLOBS[@]} == 0 ]; then
+	echo "$PROGNAME: no recoverable orphaned blobs."
+	exit
+fi
+
+if [ $DO_INTERACTIVE == 1 ]; then
+	interactive
+elif [ $DO_RECOVER == 1 ]; then
+	write_recoverable
+else
+	print_recoverable
+fi
+
-- 
2.0.0 (libgit2)

