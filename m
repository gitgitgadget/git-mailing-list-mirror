From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 11:30:16 -0500
Message-ID: <535699181d3d9_3e5aed730876@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53560F28.9020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 18:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcdkS-0005Yv-87
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 18:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbaDVQkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 12:40:40 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34131 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbaDVQki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 12:40:38 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so5888511obc.25
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=5TKQFxmDKPo+1ehxWi025YZGZ+odn4bGnFsU4dTPCOM=;
        b=p/kO3140QNHlSaGKhFf1PzVkqaniZ993nFj0LBmBmTv48rIe7BPcuEO2ubiErAo6yp
         qVXDH4RaW2+vxImuPFPiMUb0Kia+LH8zjciO05pVX1TJFs+EEC2QuQE8tzR7vYzWHCMj
         laF5l2GV2mmQnf+wtMuVvq7MxaK43dpRA0qR6GxR5ior3BInKYA82S5IZM4HN1zpt2uw
         7kB4sH86FQhcmyLZLnWQt/E0xsGy1Lvfn8P8kpHcUpLN/8WglxnfgSYgONrbVaAeuqMl
         qjHL4Q/jHpbXqqDRmeF3KIX0HDFD++lHKX2sFtoLoSooLg5UOV/T9dkccnNQKWrp48TE
         UUrg==
X-Received: by 10.60.135.106 with SMTP id pr10mr38315998oeb.15.1398184838486;
        Tue, 22 Apr 2014 09:40:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e8sm179733082oed.7.2014.04.22.09.40.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 09:40:37 -0700 (PDT)
In-Reply-To: <53560F28.9020904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246749>

Ilya Bobyr wrote:
> On 4/21/2014 1:49 PM, Felipe Contreras wrote:
> > Ilya Bobyr wrote:
> >> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> >>> This hook is invoked whenever a branch is updated, either when a branch
> >>> is created or updated with 'git branch', or when it's rebased with 'git
> >>> rebase'. It receives two parameters; the name of the branch, and the
> >>> SHA-1 of the latest commit, additionally, if there was a base commit the
> >>> branch was rebased onto, a third parameter contains it.
> >> And the old branch SHA could be found from in the reflog, correct?
> > Actually the old branch SHA-1 is actually the current one, since the branch
> > hasn't been updated at that point. Personally I don't see much value in adding
> > something the script can easily find out.
> 
> If the hook is about a branch update, I would expect it to provide both
> old and new points for the branch, along with the name.

Again, I don't see the the point of passing something that is easy to find out:
`git rev-parse $branch` gives you that information.

> The fact that for rebases it also provides new base SHA is very
> convenient.  As it is an optional argument it may make further extension
> of the interface a bit awkward.
> So, is seems reasonable to provide both from the very beginning.

So basically `git branch` would send the same SHA-1 twice.

-- 
Felipe Contreras
