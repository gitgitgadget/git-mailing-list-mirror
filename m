From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Thu, 31 Jul 2008 02:02:36 +0400
Message-ID: <20080730220236.GD7008@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de> <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com> <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de> <32541b130807301407m59eef936m5e07dd33a4eb5b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJm0-0002wc-D7
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbYG3WCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbYG3WCq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:02:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:9599 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbYG3WCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:02:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so134041fgg.17
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=u3H3IbtBtnVMQdB3prC5ZnxtvKt0OT+cbJbYDq5Pjek=;
        b=BnSiC1xDj812K/WRGQ+PUMu1GfFuonLfX94HHneQlqRl8czgjf4exFO8hO4EmFpfYt
         pGYOzBrs42X7inveu1m5RJ22N4jD0lFmmlWQ7u1S3RlnaWz/DwAjwyupiqu76VRlZVDM
         vlIEEA4o/g7iBa4O5/apnF/MkQ9sRtzc3e+8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wv5HWq3yj92LDYq1I8iBxCNoOHsa40A9Q9YaQ4Xxsu6btJSN2rT3fQGH3dHmZZsNNJ
         1TH0fe/oqG5M9vD1iy4kmzYVSzuUuovfoc84TutpfLslLW+6/JPMfIH3XNnfsfSfzay/
         pxor9JprE5yj5SkYjS1gSxaR6YBiW9zh5Iskc=
Received: by 10.86.91.12 with SMTP id o12mr5366732fgb.1.1217455363666;
        Wed, 30 Jul 2008 15:02:43 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id d4sm1700544fga.8.2008.07.30.15.02.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 15:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130807301407m59eef936m5e07dd33a4eb5b04@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90864>

On Wed, Jul 30, 2008 at 05:07:49PM -0400, Avery Pennarun wrote:
> 
> FWIW, this problem would apply to any system that incrementally
> imports into git from another system using binary deltas.

Not necessary. It depends on how import is done. You should not apply
this binary deltas to your working tree, but to files in the repo. And
obviously those files that are imported should be stored as is without
any conversion. In the same way as if you clone some git repo, you do
not apply any commit conversion to any existing commit. This conversion
should be done for *new* commits that you create locally.

So, the problem with git-svn is mostly due to how the import is done. Of
course, the other part of that problem is that conversion setting in Git
and SVN for text files specified very differently.

Dmitry
