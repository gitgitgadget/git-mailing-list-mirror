Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5E1207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 10:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbcJKKUt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:20:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:60173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752684AbcJKKUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:20:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MEXHd-1beioI0fu5-00Fldb; Tue, 11 Oct 2016 12:20:39
 +0200
Date:   Tue, 11 Oct 2016 12:20:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610111212090.35196@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de> <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bN946kIEoNdsa6knJ6Ivbldlfren1RDmXJu/vsDPT3ecO5lyGo3
 WBOIDcWIdgehtR/GqDo4B5us7tAc5keCS3wb3hAlebDmyvRsuIY7ijAeV36lHn6+7e1Nq56
 xv3CloMkTVBHhc2OenBLVvevpXPbJPdRqTUu3z8qZwkBqeMVHB7ve/9UMmyP4t96zE8YJ4P
 RSY6V6pQyDbFqecQRyjng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DHAwAQPYsk8=:/ZXz4ILLM1yroh5qaPW/rO
 niOeNZqTvZ67rTZrsxiSkaK0ZpHNIVQwhH2hJQmR/G7/FBpY/CH42FJL0YZ7WKQSnoEh5LY5V
 2D1LC7QNw4Y0AjwVQ4JStTY+Fe1maFA7QFP7gjArKnl10etKxjA8PHA0asOYTtmkcXDI5NBMA
 HhtjXNPNCtY/KriL3DgSQnasld/LazSd/HeHNRoXFwsiwoVZLRml2CYy0csIuD+Cby+Ud+Dah
 6F6IBJq4GGhGEMubi/zbTQosY+knv5KVFiFxXik/+98VTaSnrNc1OXcpUPfF9YvNjiidfM5wz
 ZObvPUvuF8t840RwULxieB4dvC1SH/EILGJSa9gjjnecBOujuu0GgzZbkGWCP0nKVh9RAN9AP
 vpQB1o23NJsiu2ah7hu9wFzeHSYVzewQ3opDfZgAUYFEwT6Svh27HBklvIS7IqseKK0Nx2xA8
 u/seUTeynjsN5JYIYDmjAkoEH0XdF6v4eboyHPgyyCXSxnRJFf3ogDq0mxf2lgKbaybiC8CeU
 R2nP2+inkbC6+9VBPuYkcHmwNauGqCEBvNinO0/nw37cHzrtKfn1tVuiyl5OdXXrbJc66zfhv
 71E6FsvVq/4GNTd/gFy2xOxO9lB/7EpUxcwotAaAOxkvkDaBwqBdZ4mX55esDsffPaAAzfZMA
 INNfZdIrIprmABkZoBJdLoYfRhS1owiE9ITHgNWbunbfvwAXkVdHNIWh685ttDhP8wsWprTOv
 +aqQSViclhXIEz1pmkvA/3OKPNJjHNpRUXYoicHIZ0TAbAv1elLmIdh9SRxD6+NXJov+RcBa4
 Efrv2S2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  	if (parent && parse_commit(parent) < 0)
> > -		/* TRANSLATORS: The first %s will be "revert" or
> > -		   "cherry-pick", the second %s a SHA1 */
> > +		/*
> > +		 * TRANSLATORS: The first %s will be a "todo" command like
> > +		 * "revert" or "pick", the second %s a SHA1.
> > +		 */
> 
> You may want to double check this with i18n folks; IIRC the tool
> that extracts TRANSLATORS: comment was somewhat particular about
> where that magic "TRANSLATORS:" token resides on a comment line and
> that is why we have this multi-line comment formatted in an unusual
> way.
> 
> Ahh, no you do not have to bug i18n folks.  47fbfded53 ("i18n: only
> extract comments marked with "TRANSLATORS:"", 2014-04-17) is an
> example of such an adjustment.

Urgh. Thanks for pointing this out to me, though. Will be fixed in the
next iteration.

> > +	while ((commit = get_revision(opts->revs))) {
> > +		struct todo_item *item = append_new_todo(todo_list);
> > +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> > +		const char *subject;
> > +		int subject_len;
> > +
> > +		item->command = command;
> > +		item->commit = commit;
> > +		item->offset_in_buf = todo_list->buf.len;
> > +		subject_len = find_commit_subject(commit_buffer, &subject);
> > +		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
> > +			find_unique_abbrev(commit->object.oid.hash,
> > +				DEFAULT_ABBREV),
> > +			subject_len, subject);
> 
> I am personally fine with this line; two things come to mind:
> 
>  - This would work just fine as-is with Linus's change to turn
>    DEFAULT_ABBREV to -1.
> 
>  - It appears that it is more fashionable to use
>    strbuf_add_unique_abbrev() these days.

Right, I actually looked at this place when I tried to decide where I
could use that function. Somehow I thought I'd not break up the flow here.

But since you asked so nicely, I'll squash this in (I personally find it
uglier, and longer, but it does use strbuf_add_unique_abbrev() now):

-- snipsnap --
@@ -906,11 +904,13 @@ static int walk_revs_populate_todo(struct todo_list
*todo_list,
                item->command = command;
                item->commit = commit;
                item->offset_in_buf = todo_list->buf.len;
+               strbuf_addstr(&todo_list->buf, command);
+               strbuf_addch(&todo_list->buf, ' ');
+               strbuf_add_unique_abbrev(&todo_list->buf,
+                                        commit->object.oid.hash,
+                                        DEFAULT_ABBREV);
                subject_len = find_commit_subject(commit_buffer, &subject);
-               strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
                command_string,
-                       find_unique_abbrev(commit->object.oid.hash,
-                               DEFAULT_ABBREV),
-                       subject_len, subject);
+               strbuf_add(&todo_list->buf, subject, subject_len);
                unuse_commit_buffer(commit, commit_buffer);
        }
        return 0;
