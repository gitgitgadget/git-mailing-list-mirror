From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] parse-opt: migrate fmt-merge-msg.
Date: Wed, 1 Oct 2008 07:56:06 -0700
Message-ID: <20081001145606.GX21310@spearce.org>
References: <20080930224623.GQ21310@spearce.org> <1222841106-26148-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:57:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl38g-0006M2-Fo
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYJAO4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYJAO4H
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:56:07 -0400
Received: from george.spearce.org ([209.20.77.23]:54197 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYJAO4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:56:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 59AA53835F; Wed,  1 Oct 2008 14:56:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222841106-26148-1-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97228>

Pierre Habouzit <madcoder@debian.org> wrote:
> @@ -347,38 +349,32 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
>  
>  int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  {
> +	const char *inpath = NULL;
> +	struct option options[] = {
> +		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
> +		OPT_BOOLEAN(0, "summary", &merge_summary, "alias for --log"),
> +		OPT_STRING('F', "file",   &inpath, "file", "file to read from"),
> +		OPT_END()


> +	argc = parse_options(argc, argv, options, fmt_merge_msg_usage, 0);
> +	if (argc > 0)
> +		usage_with_options(fmt_merge_msg_usage, options);
> +
> +	if (!inpath || strcmp(inpath, "-"))
> +		in = stdin;
> +	else {
> +		fclose(in);
> +		in = fopen(argv[2], "r");
> +		if (!in)
> +			die("cannot open %s", argv[2]);

Really argv[2]?  Shouldn't that be inpath?

-- 
Shawn.
