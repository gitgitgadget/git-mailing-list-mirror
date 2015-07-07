From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] log: add log.follow config option
Date: Tue, 07 Jul 2015 18:11:46 -0400
Organization: Twitter
Message-ID: <1436307106.5521.7.camel@twopensource.com>
References: <1436294440-20273-1-git-send-email-dturner@twopensource.com>
	 <vpqlherlk4j.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCb5v-0001QW-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 00:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbbGGWLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 18:11:54 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34159 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933057AbbGGWLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 18:11:49 -0400
Received: by qkeo142 with SMTP id o142so150770897qke.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 15:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=mdvmq97wXGS6CKI8TTFopoLSwxg76KGCeTgLhdrl3qI=;
        b=L1CfpNbUnHBcBtWRD2H4bNuST01F8Ir7RwrseM9PVvP5sXSG9Ay26qKmSLngaWRUtb
         wJ0q7zxLy+0qL4T/OSbaMlxF/h5enmHuJEbzoKdN9C+I/DFEqlo+pIPzSH/a8Tpcgvdy
         lFCmeRVAbA46nhDo0EOZS/OI7+Q8SLwCMm+aMH4WaZvxiXnD1C9yhZSXMdX3dQsypvn0
         UoE9lBGbt8q/u3Ji74E6ARaa4BOkhapTVONCTjRkBe6y2lR2sZiduBEY5zRjv68TD36l
         FUSbrH6vaEgCBXqwFO4JM4GS/LKYlNxNcCVq39gTnaLczS/kN7Q8N2zodqg9WraC5kYS
         uk5A==
X-Gm-Message-State: ALoCoQnhDmMkwSRuA5TRJ5k3s982NS8KCVyqvkrX45/u4P3JZQAZKKCGF55yLo45jovtPjP8t48d
X-Received: by 10.140.39.133 with SMTP id v5mr10701127qgv.34.1436307108740;
        Tue, 07 Jul 2015 15:11:48 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b16sm123997qga.48.2015.07.07.15.11.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 15:11:47 -0700 (PDT)
In-Reply-To: <vpqlherlk4j.fsf@anie.imag.fr>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273607>

On Tue, 2015-07-07 at 23:42 +0200, Matthieu Moy wrote:
> Hi,
> 
> Thanks for your patch. Below are some comments. Some of them are just me
> thinking out loudly (don't take it badly if I'm being negative), some
> are more serious, but all are fixable.

Thanks for the feedback!

> David Turner <dturner@twopensource.com> writes:
> 
> > From: David Turner <dturner@twitter.com>
> 
> If you configure your commiter id and your From field to the same value,
> you can avoid this distracting "From:" header.
> 
> You're lacking a Signed-off-by trailer.

Oops.  Cherry-picked over from internal repo.  Will fix.

<snip> (suggestions applied)

> > +     git log --name-status --pretty="format:%s"  path1 > current'
> 
> Whitespace: here an elsewhere, you have two spaces before path1, and we
> usually stick the > to the filename like >current.
>
> > --- a/t/t4206-log-follow-harder-copies.sh
> > +++ b/t/t4206-log-follow-harder-copies.sh
> > @@ -53,4 +53,39 @@ test_expect_success \
> >      'validate the output.' \
> >      'compare_diff_patch current expected'
> >  
> > +test_expect_success \
> > +    'git config log.follow works like --follow' \
> > +    'test_config log.follow true &&
> > +     git log --name-status --pretty="format:%s"  path1 > current'
> > +
> > +test_expect_success \
> > +    'validate the output.' \
> > +    'compare_diff_patch current expected'
> 
> I would squash these two tests. As-is, the first one doesn't really test
> anything (well, just that git log doesn't crash with log.follow).
> 
> I think you meant test_cmp, not compare_diff_patch, as you don't need
> the "similarity index" and "index ..." filtering that compare_diff_patch
> does before test_cmp.
> 
> That said, I see that you are mimicking surrounding code, which is a
> good thing for consistancy. I think the best would be to write tests in
> t4202-log.sh, which already tests the --follow option, and uses a more
> modern coding style which you can mimick.
> t4206-log-follow-harder-copies.sh is really about finding copies in
> --follow. Another option is to start your series with a patch like
> "t4206: modernize style".

I'm going to move over to t4202.  My next re-roll will include fixes for
everything you raised.  
