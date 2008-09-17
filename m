From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH/RFC 0/2] git-gui: issues with merge tool series
Date: Wed, 17 Sep 2008 16:50:17 +0400
Message-ID: <bb6f213e0809170550q5be339d1s825f95b1165e6507@mail.gmail.com>
References: <200808310052.21595.angavrilov@gmail.com>
	 <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfwVJ-0006bS-JK
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYIQMuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYIQMuV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:50:21 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:56878 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbYIQMuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:50:19 -0400
Received: by yx-out-2324.google.com with SMTP id 8so933991yxm.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ihp/jPMc0bbGq5fJHcZq64GFkcR8E5rv93OjnJW6p18=;
        b=Qn5icCi2fbS0LOJN+nTv3AtGTGCxe61LFrtZOsjiWd+bHL+SzPq2LnQu0OHbOA+Prh
         nBshllsjWzbE9UhyD2oDcldQMRP9rXjKF0MOIzdEcGEVX6ld3ewMuw/4wE6M1disyzsB
         NBMIxeCKZJuQG1GFy+l+xSohl8E9FKw7FfhIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lXSDqvpeHxWxkWEgsBrp8hYpt7A1ElUqhGGkZ3AoJ4PIkvD5WhLARKNose0Hhkcxi0
         Lx9ajV7OtweKhYvpQFWAD9GCRxIBOIOTYuq+DX/Osa5ZgE8nbBpyKqnBXezFfIccaiNd
         Bz/2iGg+3zNYC4UCdy8nRIkYTLVoOj80M6UiU=
Received: by 10.103.250.9 with SMTP id c9mr1781900mus.9.1221655817079;
        Wed, 17 Sep 2008 05:50:17 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 17 Sep 2008 05:50:17 -0700 (PDT)
In-Reply-To: <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96105>

On Wed, Sep 17, 2008 at 3:40 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> 1. The inability to stage a conflicted file by clicking the icon is
>   *very* disruptive. The new menu entry "Stage Working Copy" is
>   really only a workaround, and it shows.

I can see two ways to fix it:

1) Allow that icon to work only if the diff is currently displayed,
and also ask for confirmation if there are any conflict markers
present.

   Problem: What should it do with modify/delete conflicts, which
don't have any conflict markers?

2) Much harder: implement complete one-click undo. This involves
saving information from the index somewhere, and forcing such items to
remain in the 'staged' list, even if the index isn't different from
the tree version any more.

   By the way, is there a simple way to re-create a conflict file from
the saved multistage index entries?


Probably the best fix is some combination of these two.


> Furthermore, the operations "Use local version" and "Use remote
> version" could be much more useful. They could serve as "merge
> shortcuts": These operations should only use the "local" or "remote"
> part inside the conflict markers, and not also reset the part that
> is not visible. In the current form I found them useful only in the
> modify/delete conflict cases, where I picked the "delete" part.

That was simply a reimplementation of git-mergetool with proper GUI.
It cannot do per-hunk resolution either...


Alexander
