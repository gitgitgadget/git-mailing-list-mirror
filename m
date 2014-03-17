From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 17:29:33 +0100
Message-ID: <532722ED.1010500@alum.mit.edu>
References: <1394901553-69548-1-git-send-email-quintus.public@gmail.com> <1394901553-69548-2-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 17:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPaQ9-0000us-7U
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 17:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbaCQQ3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 12:29:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55560 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755513AbaCQQ3h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 12:29:37 -0400
X-AuditID: 1207440d-f79d86d0000043db-b4-532722f0f1e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F6.A3.17371.0F227235; Mon, 17 Mar 2014 12:29:36 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD44AD.dip0.t-ipconnect.de [79.221.68.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2HGTYLf017637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Mar 2014 12:29:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394901553-69548-2-git-send-email-quintus.public@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqPtBST3Y4Mt2SYuuK91MFu+6+5kd
	mDx2zrrL7vF5k1wAUxS3TVJiSVlwZnqevl0Cd0bH+Y2MBa/KKj5M4GpgfB/ZxcjBISFgIrHl
	FmsXIyeQKSZx4d56ti5GLg4hgcuMEid/T2KHcM4zSRzeu4wZpIpXQFvi04TdbCA2i4CqxN9j
	R8DibAK6Eot6mplAbFGBYInVlx+wQNQLSpyc+QTMFhHQl5iyZy4byGJmAXGJ/n9gYWEBf4nr
	bz8yQ+xqZZTon7wYbD6ngKfEqru/mCAOFZfoaQwCCTML6Ei863vADGHLS2x/O4d5AqPgLCTb
	ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkODl3cH4f53M
	IUYBDkYlHt4XbOrBQqyJZcWVuYcYJTmYlER5/8gDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	XuIFyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHh/KQI1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiN74YGL8gKR6gve9A2nmLCxJzgaIQracYdTk2
	bFvTyCTEkpeflyolzvtIAahIAKQoozQPbgUsVb1iFAf6WJhXFpi4hHiAaQ5u0iugJUxASxZN
	VwNZUpKIkJJqYFSeX+/jKrIoert0/V2FnVuvPZv3M0bDWbHm0tZnr16H7JO4pStR+mLKrauN
	9xx+RDS77JL1Vzlg6Tmt+sauz0dWCryP/rLsSf/d+rtlkWzqjHO8t3+00T66MSo0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244255>

Quint,

Thanks for v3 of the patch and for sticking with it.  See a few comments
below.

On 03/15/2014 05:39 PM, Quint Guvernator wrote:
> memcmp() is replaced with negated starts_with() when comparing strings
> from the beginning and when it is logical to do so. starts_with() looks
> nicer and it saves the extra argument of the length of the comparing
> string.
> 
> Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
> ---
>  builtin/apply.c                           |  6 +++---
>  builtin/for-each-ref.c                    |  2 +-
>  builtin/get-tar-commit-id.c               |  2 +-
>  builtin/mktag.c                           |  8 ++++----
>  builtin/patch-id.c                        | 18 +++++++++---------
>  commit.c                                  |  4 ++--
>  connect.c                                 |  6 +++---
>  contrib/convert-objects/convert-objects.c |  6 +++---
>  convert.c                                 |  2 +-
>  http-walker.c                             |  2 +-
>  imap-send.c                               |  6 +++---
>  pack-write.c                              |  2 +-
>  remote.c                                  |  2 +-
>  13 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0189523..de84dce 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
>  		 * l10n of "\ No newline..." is at least that long.
>  		 */
>  		case '\\':
> -			if (len < 12 || memcmp(line, "\\ ", 2))
> +			if (len < 12 || !starts_with(line, "\\ "))
>  				return -1;
>  			break;
>  		}
> @@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
>  	 * it in the above loop because we hit oldlines == newlines == 0
>  	 * before seeing it.
>  	 */
> -	if (12 < size && !memcmp(line, "\\ ", 2))
> +	if (12 < size && starts_with(line, "\\ "))
>  		offset += linelen(line, size);
>  
>  	patch->lines_added += added;
> @@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
>  	unsigned long oldlines = 0, newlines = 0, context = 0;
>  	struct fragment **fragp = &patch->fragments;
>  
> -	while (size > 4 && !memcmp(line, "@@ -", 4)) {
> +	while (size > 4 && starts_with(line, "@@ -")) {
>  		struct fragment *fragment;
>  		int len;
>  
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 3e1d5c3..4135980 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -193,7 +193,7 @@ static int verify_format(const char *format)
>  		at = parse_atom(sp + 2, ep);
>  		cp = ep + 1;
>  
> -		if (!memcmp(used_atom[at], "color:", 6))
> +		if (starts_with(used_atom[at], "color:"))
>  			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
>  	}
>  	return 0;
> diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
> index aa72596..6409c26 100644
> --- a/builtin/get-tar-commit-id.c
> +++ b/builtin/get-tar-commit-id.c
> @@ -29,7 +29,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
>  		die("git get-tar-commit-id: read error");
>  	if (header->typeflag[0] != 'g')
>  		return 1;
> -	if (memcmp(content, "52 comment=", 11))
> +	if (!starts_with(content, "52 comment="))
>  		return 1;
>  
>  	n = write_in_full(1, content + 11, 41);

This hunk uses the magic number "11" a couple lines later.  Junio (I
think rightly) objected [1] to rewrites in these circumstances because
they make it even less obvious where the constant came from and thereby
make the complete elimination of the hard-coded constant *more* difficult.

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 640ab64..70385ac 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -49,7 +49,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  
>  	/* Verify object line */
>  	object = buffer;
> -	if (memcmp(object, "object ", 7))
> +	if (!starts_with(object, "object "))
>  		return error("char%d: does not start with \"object \"", 0);
>  
>  	if (get_sha1_hex(object + 7, sha1))

Ditto.

> @@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  
>  	/* Verify type line */
>  	type_line = object + 48;
> -	if (memcmp(type_line - 1, "\ntype ", 6))
> +	if (!starts_with(type_line - 1, "\ntype "))
>  		return error("char%d: could not find \"\\ntype \"", 47);
>  
>  	/* Verify tag-line */
> @@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  		return error("char%"PRIuMAX": could not find next \"\\n\"",
>  				(uintmax_t) (type_line - buffer));
>  	tag_line++;
> -	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
> +	if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
>  		return error("char%"PRIuMAX": no \"tag \" found",
>  				(uintmax_t) (tag_line - buffer));
>  
> @@ -98,7 +98,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  	/* Verify the tagger line */
>  	tagger_line = tag_line;
>  
> -	if (memcmp(tagger_line, "tagger ", 7))
> +	if (!starts_with(tagger_line, "tagger "))
>  		return error("char%"PRIuMAX": could not find \"tagger \"",
>  			(uintmax_t) (tagger_line - buffer));
>  

Ditto.

> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 3cfe02d..7e02f2c 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -66,13 +66,13 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  		char *p = line;
>  		int len;
>  
> -		if (!memcmp(line, "diff-tree ", 10))
> +		if (starts_with(line, "diff-tree "))
>  			p += 10;

Ditto.  OK, I'm starting to see a pattern here so I'll leave you to look
for similar problems with later changes.

> -		else if (!memcmp(line, "commit ", 7))
> +		else if (starts_with(line, "commit "))
>  			p += 7;
> -		else if (!memcmp(line, "From ", 5))
> +		else if (starts_with(line, "From "))
>  			p += 5;
> -		else if (!memcmp(line, "\\ ", 2) && 12 < strlen(line))
> +		else if (starts_with(line, "\\ ") && 12 < strlen(line))
>  			continue;
>  
>  		if (!get_sha1_hex(p, next_sha1)) {
> @@ -81,14 +81,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  		}
>  
>  		/* Ignore commit comments */
> -		if (!patchlen && memcmp(line, "diff ", 5))
> +		if (!patchlen && !starts_with(line, "diff "))
>  			continue;
>  
>  		/* Parsing diff header?  */
>  		if (before == -1) {
> -			if (!memcmp(line, "index ", 6))
> +			if (starts_with(line, "index "))
>  				continue;
> -			else if (!memcmp(line, "--- ", 4))
> +			else if (starts_with(line, "--- "))
>  				before = after = 1;
>  			else if (!isalpha(line[0]))
>  				break;
> @@ -96,14 +96,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>  
>  		/* Looking for a valid hunk header?  */
>  		if (before == 0 && after == 0) {
> -			if (!memcmp(line, "@@ -", 4)) {
> +			if (starts_with(line, "@@ -")) {
>  				/* Parse next hunk, but ignore line numbers.  */
>  				scan_hunk_header(line, &before, &after);
>  				continue;
>  			}
>  
>  			/* Split at the end of the patch.  */
> -			if (memcmp(line, "diff ", 5))
> +			if (!starts_with(line, "diff "))
>  				break;
>  
>  			/* Else we're parsing another header.  */
> diff --git a/commit.c b/commit.c
> index fa401ae..f3ca1db 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -90,13 +90,13 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
>  
>  	if (buf + 6 >= tail)
>  		return 0;
> -	if (memcmp(buf, "author", 6))
> +	if (!starts_with(buf, "author"))

Ditto, except that here the magic number is used *before* your change.

I stopped reading the changes here because I expect there will be a lot
more of the same problem.

>  		return 0;
>  	while (buf < tail && *buf++ != '\n')
>  		/* nada */;
>  	if (buf + 9 >= tail)
>  		return 0;
> -	if (memcmp(buf, "committer", 9))
> +	if (!starts_with(buf, "committer"))
>  		return 0;
>  	while (buf < tail && *buf++ != '>')
>  		/* nada */;
> diff --git a/connect.c b/connect.c
> index 4150412..1ff0540 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -18,7 +18,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
>  	if (!flags)
>  		return 1;
>  
> -	if (len < 5 || memcmp(name, "refs/", 5))
> +	if (len < 5 || !starts_with(name, "refs/"))
>  		return 0;
>  
>  	/* Skip the "refs/" part */
> @@ -30,11 +30,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
>  		return 0;
>  
>  	/* REF_HEADS means that we want regular branch heads */
> -	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
> +	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
>  		return 1;
>  
>  	/* REF_TAGS means that we want tags */
> -	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
> +	if ((flags & REF_TAGS) && starts_with(name, "tags/"))
>  		return 1;
>  
>  	/* All type bits clear means that we are ok with anything */
> diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
> index f3b57bf..9fdc730 100644
> --- a/contrib/convert-objects/convert-objects.c
> +++ b/contrib/convert-objects/convert-objects.c
> @@ -245,7 +245,7 @@ static void convert_date(void *buffer, unsigned long size, unsigned char *result
>  	size -= 46;
>  
>  	/* "parent <sha1>\n" */
> -	while (!memcmp(buffer, "parent ", 7)) {
> +	while (starts_with(buffer, "parent ")) {
>  		memcpy(new + newlen, buffer, 48);
>  		newlen += 48;
>  		buffer = (char *) buffer + 48;
> @@ -270,11 +270,11 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
>  	void *orig_buffer = buffer;
>  	unsigned long orig_size = size;
>  
> -	if (memcmp(buffer, "tree ", 5))
> +	if (!starts_with(buffer, "tree "))
>  		die("Bad commit '%s'", (char *) buffer);
>  	convert_ascii_sha1((char *) buffer + 5);
>  	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
> -	while (!memcmp(buffer, "parent ", 7)) {
> +	while (starts_with(buffer, "parent ")) {
>  		convert_ascii_sha1((char *) buffer + 7);
>  		buffer = (char *) buffer + 48;
>  	}
> diff --git a/convert.c b/convert.c
> index ab80b72..30882e2 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -543,7 +543,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
>  		len -= dollar + 1 - src;
>  		src  = dollar + 1;
>  
> -		if (len > 3 && !memcmp(src, "Id:", 3)) {
> +		if (len > 3 && starts_with(src, "Id:")) {
>  			dollar = memchr(src + 3, '$', len - 3);
>  			if (!dollar)
>  				break;
> diff --git a/http-walker.c b/http-walker.c
> index 1516c5e..8ae7d69 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -267,7 +267,7 @@ static void process_alternates_response(void *callback_data)
>  				i += 3;
>  				serverlen = strlen(base);
>  				while (i + 2 < posn &&
> -				       !memcmp(data + i, "../", 3)) {
> +				       starts_with(data + i, "../")) {
>  					do {
>  						serverlen--;
>  					} while (serverlen &&
> diff --git a/imap-send.c b/imap-send.c
> index 0bc6f7f..019de18 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -524,7 +524,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
>  	if (Verbose) {
>  		if (imap->num_in_progress)
>  			printf("(%d in progress) ", imap->num_in_progress);
> -		if (memcmp(cmd->cmd, "LOGIN", 5))
> +		if (!starts_with(cmd->cmd, "LOGIN"))
>  			printf(">>> %s", buf);
>  		else
>  			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
> @@ -802,7 +802,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  				resp = DRV_OK;
>  			else {
>  				if (!strcmp("NO", arg)) {
> -					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
> +					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || starts_with(cmd, "[TRYCREATE]"))) { /* SELECT, APPEND or UID COPY */
>  						p = strchr(cmdp->cmd, '"');
>  						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
>  							resp = RESP_BAD;
> @@ -827,7 +827,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  				} else /*if (!strcmp("BAD", arg))*/
>  					resp = RESP_BAD;
>  				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
> -					 memcmp(cmdp->cmd, "LOGIN", 5) ?
> +					 !starts_with(cmdp->cmd, "LOGIN") ?
>  							cmdp->cmd : "LOGIN <user> <pass>",
>  							arg, cmd ? cmd : "");
>  			}
> diff --git a/pack-write.c b/pack-write.c
> index 9b8308b..c3bfa16 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -289,7 +289,7 @@ char *index_pack_lockfile(int ip_out)
>  	 * later on.  If we don't get that then tough luck with it.
>  	 */
>  	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n' &&
> -	    memcmp(packname, "keep\t", 5) == 0) {
> +	    !starts_with(packname, "keep\t") == 0) {
>  		char path[PATH_MAX];
>  		packname[45] = 0;
>  		snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
> diff --git a/remote.c b/remote.c
> index 5f63d55..bd02b0e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1149,7 +1149,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  	case 1:
>  		break;
>  	case 0:
> -		if (!memcmp(dst_value, "refs/", 5))
> +		if (starts_with(dst_value, "refs/"))
>  			matched_dst = make_linked_ref(dst_value, dst_tail);
>  		else if (is_null_sha1(matched_src->new_sha1))
>  			error("unable to delete '%s': remote ref does not exist",
> 

In your cover letter you said:

> I've looked through the list's responses and removed the most objectionable
> hunks from the patch v2, especially in cases where starts_with either hurts
> readability or further obscures the use of magic numbers. Let me know what you
> all think about the changes.

In any open-source project it is important to optimize for the time of
the reviewer, because code-review is a relatively tedious task and is
therefore often the bottleneck for progress.  Therefore I suggest that
you turn your approach on its head.  Don't "remove the most
objectionable hunks" but rather *include only the best hunks*--the ones
that you can stand behind 100%, which you think are an unambiguous
improvement, and that the reviewer can accept without reservations.

It would be much better for you to submit only a handful of changes (or
even only one!) that is perfect, rather than throwing a bunch at the
wall and asking the reviewer to pick between the good and the bad.  As
you gain experience and learn about the preferences of the Git project,
you will get a better feel for the boundary between
acceptable/unacceptable patches, and *then* you will be able to start
submitting patches closer to the boundary.

Cheers,
Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/244005

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
