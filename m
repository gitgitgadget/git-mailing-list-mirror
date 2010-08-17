From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 2/2] blame: fix output in case of replacement by using parse_commit_repl()
Date: Tue, 17 Aug 2010 08:16:18 +0200
Message-ID: <201008170816.18600.chriscool@tuxfamily.org>
References: <20100817015901.5592.419.chriscool@tuxfamily.org> <AANLkTimMXmi1ZhVYXtbMz3doOUZMzbRggqcUY0L7wKyY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 08:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlFTQ-0002KI-Ol
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab0HQGQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:16:28 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46767 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab0HQGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:16:27 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 804FB818023;
	Tue, 17 Aug 2010 08:16:20 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTimMXmi1ZhVYXtbMz3doOUZMzbRggqcUY0L7wKyY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153702>

On Tuesday 17 August 2010 05:44:11 Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 17, 2010 at 11:59 AM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > git blame was not showing the sha1 of the replacement commit while
> > it was properly showing other information from the replacement commit,
> > because parse_commit() is buggy regarding replacement.
> > 
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  builtin/blame.c    |    4 ++--
> >  t/t6050-replace.sh |    8 ++++++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 8f9e7b0..c469e09 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -1226,7 +1226,7 @@ static void pass_blame(struct scoreboard *sb,
> > struct origin *origin, int opt)
> > 
> >                        if (sg_origin[i])
> >                                continue;
> > -                       if (parse_commit(p))
> > +                       if (parse_commit_repl(&p))
> 
> This is the hard way. There are another ~40 parse_commit() calls
> elsewhere. Most of them are in git commands, so we can check one by
> one. There are some calls in revision.c, sha1_name.c, tree.c,
> upload-pack.c and walker.c, which may be used in many places. Checking
> them would be harder.

Yeah, I will try to provide test cases but it may not be possible in some 
cases.

Best regards,
Christian.
