From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 2/3] sha1_name: get_sha1_with_context learns to
 follow symlinks
Date: Sat, 09 May 2015 16:34:30 -0400
Organization: Twitter
Message-ID: <1431203670.24139.5.camel@ubuntu>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
	 <1431124726-22562-2-git-send-email-dturner@twopensource.com>
	 <xmqq7fsiifcz.fsf@gitster.dls.corp.google.com>
	 <xmqqlhgxhcqb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 22:34:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrBSK-0008Js-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 22:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbbEIUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 16:34:34 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33359 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbEIUee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 16:34:34 -0400
Received: by qgdy78 with SMTP id y78so51633755qgd.0
        for <git@vger.kernel.org>; Sat, 09 May 2015 13:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=eOimkOLZG6uqkLorloNQJCTJpwjkuj8fqydQl0Z6slQ=;
        b=MbYo9lrhPtbC6APBFhuZUkM1n5IHXDxVMHy2+sBMOdIVH8lg1L1K/lQbDUlr3bPtWi
         1iQtPDkgre7jxuydM//LAIuP8Cr3zYXdmDmHq8gp3Mds7wGkFuY7qJrTVU+Y3rSbkYtw
         6l+gfVFno0plDj5FzoqwbBPvaKQLvt+VO9M0ZVi7H5hcSe2VIGhCguSq7fxyqr80qeBN
         APR/t/dkZOX0c9mbuY03+5CxcL966iEg9jmyrrm+XTuiJ/GiKvg7W1vtmAmNjsBY+l6r
         PN5ADwoc01gFgLNuMW086u0knJCW5eqAgxW2pOeST2NLLRAZBKeXh9h1X7gCjB1p/Gt3
         SONw==
X-Gm-Message-State: ALoCoQkadYZrVyShFKpUV5O87/miLBF588CfXup4Nl97Pk/TK9jv52dIPqVZuLPiBNmWyprO/Cr/
X-Received: by 10.229.54.196 with SMTP id r4mr5243645qcg.15.1431203672451;
        Sat, 09 May 2015 13:34:32 -0700 (PDT)
Received: from [10.0.1.16] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p67sm6489132qkh.10.2015.05.09.13.34.31
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2015 13:34:31 -0700 (PDT)
In-Reply-To: <xmqqlhgxhcqb.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268711>

On Sat, 2015-05-09 at 10:39 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > dturner@twopensource.com writes:
> >
> >> From: David Turner <dturner@twitter.com>
> >>
> >> Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
> >> when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
> >> is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
> >> ONLY_TO_DIE triggers does not consider symlinks.
> >
> > Is "does not consider" something fundamental, or it just happens to
> > be that way right now?
> 
> Regardless of the answer to this question, I find the last part of
> this hunk puzzling.

You're right -- this code is wrong, for the reasons you explain.  I'm
going to follow your earlier suggestion and use a strbuf for the new
field.
