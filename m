From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 18 Aug 2009 08:43:37 +0700
Message-ID: <fcaeb9bf0908171843x6ab0763dqff7e8aea0443c374@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com> 
	<alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de> <200908180217.35963.jnareb@gmail.com> 
	<2729632a0908171734p16d6ee7dm5f62848f7625ffbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 18 03:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdDk5-00057S-K1
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 03:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572AbZHRBn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758566AbZHRBn5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 21:43:57 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:63510 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531AbZHRBn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 21:43:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so3157868and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j6xqQGqVwJb1Ux6wL6d3mzNIULQNHq4xt8ozU6H2ZBE=;
        b=FZrztwOZFfL+fWXQM9r7vdpJYwGLaq4vsvKTG92dEJVR/ES6tmuOSXDPpNGLBN3a73
         DBhoFzDmuXQCdpfvAooecXne8JFJl+ZTfVql/YfoWOLvwSVSXJJAzeUvzQqGFt69vU7+
         Qf01MnkxdM9MBSpQozJ74DejdQW2SUSkGwIJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JhAjyFhwSC0WJgsp3G++3g40HiaoSs8qgVzDYSzRjj3u9s/Erk2KpHeYz9+4dtoIbI
         7DsnGQijexbAkyzJYsX9lLPYuAqE0sd6G81btbGVMlAYeacv7A4NhiuXssBveRgtYGcM
         eL8PGQE1grgsFHbbtAVlDpPLk+4FoFZ1/u3k8=
Received: by 10.101.62.13 with SMTP id p13mr4426549ank.25.1250559837131; Mon, 
	17 Aug 2009 18:43:57 -0700 (PDT)
In-Reply-To: <2729632a0908171734p16d6ee7dm5f62848f7625ffbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126337>

On Tue, Aug 18, 2009 at 7:34 AM, <skillzero@gmail.com> wrote:
> On Mon, Aug 17, 2009 at 5:17 PM, Jakub Narebski<jnareb@gmail.com> wrote:
>
>> There is e.g. question if "git grep" should search "no-checkout" files;
>> in the "assume-unchanged" case it should, I think, search index version.
>
> I would like it to git grep to not search paths outside the sparse
> area (although --no-sparse would be nice for git grep in case you did
> want to search everything). The main reason I want sparse checkouts is
> for performance reasons. For example, git grep can take 10 minutes on
> my full repository so excluding paths outside the sparse area would
> reduce that to a few seconds.

That's a porcelain question that I'd leave it for now. FWIW you can do
something like this:

git ls-files -v|grep '^H'|cut -c 2-|xargs git grep

/me misses "cleartool find"
-- 
Duy
