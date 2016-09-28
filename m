Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC74820986
	for <e@80x24.org>; Wed, 28 Sep 2016 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbcI1Ftz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 01:49:55 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35896 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbcI1Fty (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 01:49:54 -0400
Received: by mail-qt0-f174.google.com with SMTP id r60so2615449qtd.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ez11Oba67mjytGXdDqkjeQCL+Pb/7464sCw3sa/lQoo=;
        b=C1UtWi67MClRG85+plz88VAwqOXIDCSkqBTYRMLaDU5zeRCrnSuYeCFptpbAcfpSHS
         w8Q5eGt0qfiwcstE8f0tI15iXNKRVrK5Z/cZ8WyeMRzUVThNO4qLh51upqFSgQOT6IC5
         dD8YpAX35XxM2Gq83pXOWG2UsLfRGXnTlzyo2LXDNB7as7RKj7URTYMiouBfuaToFeMz
         aB0KruU8eCqTKedNXyskYmGznxG80ryuzOVwKrsUBj+oCBqVPrjMkjQPxw0YBNbxewcq
         +9eh5VyhoSiuWlLqacpJqpiP9gRCP7WNmragWyjl65zApVUbgLNj1B70NAHNvqMEY0sY
         uVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ez11Oba67mjytGXdDqkjeQCL+Pb/7464sCw3sa/lQoo=;
        b=b7nGDC6AMljGcDMn6o4WsaqlBuAYVWTubusOwc2L01rx/iLSzySNHKolnuqiycxF/9
         nYP9ixrq+gEBVr2xhEbrTwRtyxLpWqmQAwkjmqXXPCaxHKkdtoiPWofdbPL+90U0ABOV
         9X7wN84MM7h6rWMO2MhJGO3L54O4bKg3+VJxG8dYCpPMxz71e4uaZcIy9qBaaXANoGbi
         T6g5/DzCx24fRa9s3LCVTB4mTBgo0gWhGRugbTxTXOhlwRoa1Kk2VFu5S4HuuDRv3rYA
         kbyP66GK07OLOwYjJS20D9CkLP0SDUdExTJ3ApJlmsbi52fqEMusua4EtwKcKZ3MXHmf
         I1XA==
X-Gm-Message-State: AA6/9RlNF5eq9vAGRMlAu0dxy2DKb8h4/PlVgfA5/CHRNUClshzqzDTHj1OAc08HF74tLw==
X-Received: by 10.237.49.5 with SMTP id 5mr30878655qtg.136.1475041793231;
        Tue, 27 Sep 2016 22:49:53 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id h46sm3153006qte.21.2016.09.27.22.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 22:49:52 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 01:49:51 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 11/11] Resumable clone: implement primer logic in
 git-clone
Message-ID: <20160928054951.GF3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
 <xmqqy42rh156.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy42rh156.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 04:32:05PM -0700, Junio C Hamano wrote:
> >  -----------
> > @@ -172,6 +173,12 @@ objects from the source repository into a pack in the cloned repository.
> >  	via ssh, this specifies a non-default path for the command
> >  	run on the other end.
> >  
> > +--prime-clone <prime-clone>::
> > +-p <prime-clone>::
> 
> Not many other options have single letter shorthand.  Is it expected
> that it is worth to let this option squat on a short-and-sweet "-p",
> perhaps because it is so frequently used?

I based my decision more on precedent than value--the "--upload-pack" option
had the shorthand "-u".

> > @@ -40,17 +42,20 @@ static const char * const builtin_clone_usage[] = {
> >  
> >  static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
> >  static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> > +static int option_resume;
> >  static char *option_template, *option_depth;
> > -static char *option_origin = NULL;
> > +static const char *option_origin = NULL;
> 
> Is this change related to anything you are doing here?
> 
> If you are fixing things while at it, please don't ;-) If you really
> want to, please also remove " = NULL", from this line and also from
> the next line.  Also do not add " = NULL" at the end of alt_res.
> 

Yes, it was because remote_config uses all const char* strings, and .name gets
assigned to option_origin when it pulls the previous info from config. I looked
to see if option_origin's underlying string is ever modified in a way that
makes it ineligible to be const, and it wasn't.

So, I should remove the NULLs here? And then initalize alt_res to NULL in
cmd_clone?

> >  static char *option_branch = NULL;
> >  ...
> > +static const struct alt_resource *alt_res = NULL;
> 
> > +static char *get_filename(const char *dir)
> > +{
> > +	char *dir_copy = xstrdup(dir);
> > +	strip_trailing_slashes(dir_copy);
> > +	char *filename, *final = NULL;
> > +
> > +	filename = find_last_dir_sep(dir);
> > +
> > +	if (filename && *(++filename))
> > +		final = xstrdup(filename);
> > +
> > +	free(dir_copy);
> > +	return final;
> > +}
> 
> Hmph, don't we have our own basename(3) lookalike that knows about
> dir-sep already?

Whoops, did not catch that. Thanks!

> > @@ -562,7 +614,7 @@ static void write_remote_refs(const struct ref *local_refs)
> >  		die("%s", err.buf);
> >  
> >  	for (r = local_refs; r; r = r->next) {
> > -		if (!r->peer_ref)
> > +		if (!r->peer_ref || ref_exists(r->peer_ref->name))
> >  			continue;
> >  		if (ref_transaction_create(t, r->peer_ref->name, r->old_oid.hash,
> >  					   0, NULL, &err))
> 
> What is this change about?

Because resumable clone is supposed to handle halting, I included the
possibility of halting after the final fetch happened and remote refs were
updated (basically anything after resumable download happens). This change
basically says "If the remote ref was not previously written, then write it."
Because the write is all-or-nothing, this means the logic should either write
all of the intended references, or none of them (because they were written
in the previous invocation).

> > +static const char *setup_and_index_pack(const char *filename)
> > +{
> > +	const char *primer_idx_path = NULL, *primer_bndl_path = NULL;
> > +	primer_idx_path = replace_extension(filename, ".pack", ".idx");
> > +	primer_bndl_path = replace_extension(filename, ".pack", ".bndl");
> > +
> > +	if (!(primer_idx_path && primer_bndl_path)) {
> > +		warning("invalid pack filename '%s', falling back to full "
> > +			"clone", filename);
> > +		return NULL;
> > +	}
> > +
> > +	if (!file_exists(primer_bndl_path)) {
> > +		if (do_index_pack(filename, primer_idx_path)) {
> > +			warning("could not index primer pack, falling back to "
> > +				"full clone");
> > +			return NULL;
> > +		}
> > +	}
> 
> Can it be another (undetected) failure mode that .bndl somehow
> already existed, but not .idx, leaving the resulting object store in
> an incosistent state?  Can do_index_pack() fail and leave .bndl
> behind to get you into such a state?

I don't think so, based on looking at builtin/index-pack.c. write_bundle_file()
happens at the very end of final(), which is long after the process created the
resulting .idx, or has died in the event one is not created. There also is no
automatic cleanup of .idx after that if the process dies somehow after .bndl
is written.

> > +static int write_bundle_refs(const char *bundle_filename)
> > +{
> > +	struct ref_transaction *t;
> > +	struct bundle_header history_tips;
> > +	const char *temp_ref_base = "resume";
> > +	struct strbuf err = STRBUF_INIT;
> > +	int i;
> > +
> > +	init_bundle_header(&history_tips, bundle_filename);
> > +	read_bundle_header(&history_tips);
> > +
> > +	t = ref_transaction_begin(&err);
> > +	for (i = 0; i < history_tips.references.nr; i++) {
> > +		struct strbuf ref_name = STRBUF_INIT;
> > +		strbuf_addf(&ref_name, "refs/temp/%s/%s/temp-%s",
> > +			    option_origin, temp_ref_base,
> > +			    sha1_to_hex(history_tips.references.list[i].sha1));
> 
> Can we do this without polluting refs/temp/ namespace?
> 
> I am imagining that you are first fetching the .pack file from
> sideways when primer service is available, running index-pack on it
> to produce the bundle, and the step after that is to run "git fetch"
> against the original remote to fill the gap between the bit-stale
> history you got in the bundle and the reality that has progressed
> since the primer pack was made, and you need a way to tell to the
> other end that you already have the history leading to these refs
> when you run "git fetch".  I think a bit better way to do so is to
> send these has ".have" while you run the "fetch".
> 
> Wouldn't it do if you add the "--advertise-bundle-tips=<bndl>"
> option to "git fetch", move the code to read the bundle header to
> it, and point the bundle's filename with the option when you spawn
> "git fetch"?

My implementation is definitely a minimum working model. I was hoping to
move to something cleaner.

Is this new option preferable to leveraging the "--reference" option you
mentioned in the earlier discussion? I thought that was a clean solution,
especially because it uses an existing option. Additionally, would there be
any use for this new fetch option outside of cloning? If so, I could see the
value--otherwise, knowing that we want to keep as much resume-specific
knowledge inside clone as possible, "--reference" with a .bndl seems better.

- Kevin
