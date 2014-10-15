From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 2/3] mergetool: don't require a work tree for
 --tool-help
Date: Tue, 14 Oct 2014 23:35:11 -0700
Message-ID: <20141015063509.GB14751@gmail.com>
References: <1413016778-94829-1-git-send-email-davvid@gmail.com>
 <1413016778-94829-2-git-send-email-davvid@gmail.com>
 <xmqqsiir3hlk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeIAi-0003Dp-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 08:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaJOGex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 02:34:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64950 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbaJOGev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 02:34:51 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so682999pde.36
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qp84LQqZPWG2pevbW61uOb9XP0mFuA0DFDgPh7OJXqg=;
        b=Qva2mRvYABn5hhxLSrtIvXCwIK8nzHYr67oK7J82lfwPVQRA7VqS930z+/5rzqw0a8
         PZLX1OkulhJVvRr2uosT/Bhtyz5TrPXwU7rvp9PtOY5RlRl2IzLXcQGLCCrl2SToAV6J
         2dwel4uPMWfE7hjrwolscyxt4PbDpb+uYf/DO16aIQbGDyf3WGDozwX8f1h/3ZninhmP
         o3kRlZp50qJQF57+A2Z3lTFaT5h9HIwezN0YFJB/DeTWWQpLcoVMvBCLx56Vw0P9x9Dm
         JTpo/wQwmPDpxoBHC3z3Pf535+/E1bN8nwP6PgxOH0Z5pPVGJiovEyBWPAAcWDPbA4m4
         wWIg==
X-Received: by 10.66.251.194 with SMTP id zm2mr10144666pac.33.1413354891381;
        Tue, 14 Oct 2014 23:34:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ft12sm16051396pdb.43.2014.10.14.23.34.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 23:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqsiir3hlk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 12:16:55PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > From: Charles Bailey <cbailey32@bloomberg.net>
> >
> > Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > Changes since v2:
> >
> > This now uses the new git_dir_init function.
> >
> >  git-mergetool.sh | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > index 96a61ba..cddb533 100755
> > --- a/git-mergetool.sh
> > +++ b/git-mergetool.sh
> > @@ -10,11 +10,11 @@
> >  
> >  USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
> >  SUBDIRECTORY_OK=Yes
> > +NONGIT_OK=Yes
> >  OPTIONS_SPEC=
> >  TOOL_MODE=merge
> >  . git-sh-setup
> >  . git-mergetool--lib
> > -require_work_tree
> >  
> >  # Returns true if the mode reflects a symlink
> >  is_symlink () {
> > @@ -378,6 +378,9 @@ prompt_after_failed_merge () {
> >  	done
> >  }
> >  
> > +require_work_tree
> > +git_dir_init
> 
> This is somewhat curious.  Shouldn't the order of these swapped?

Yes.  I'll send a replacement patch for 2/3 only.
-- 
David
