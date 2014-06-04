From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] receive-pack: optionally deny case clone refs
Date: Wed, 04 Jun 2014 13:24:44 -0400
Organization: Twitter
Message-ID: <1401902684.18134.144.camel@stross>
References: <1401851607-8255-1-git-send-email-dturner@twitter.com>
	 <538EB748.3050300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:40:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFAX-0001Hf-0x
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 19:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbaFDRYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 13:24:48 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:41625 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaFDRYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 13:24:47 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so16121379qga.34
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 10:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=W+4t7QYA/bk8UY2HeCvID3hR+OTDf9zo9s4i84q+34o=;
        b=Pd6NupYcJHjvoRhnMAao6SiJbCp9C16OgBgsRZ1INceektUxyqJ7bOvZ4HMXZ4B6XQ
         oZdEKXS+do2JDaVyDtGwMZcxLBaPeGJlRshhGwv3nSywcF+YJc+jzL1dfWF+Jaf9oF+O
         F9GNztwLG1uW4uhuR0K8+Zva+h7Miu7iCFRZf6+hEtJ7vLzl8mE/V2AV/VxFEjyBeX9C
         qUnWlGnbC46gCLgn3CdX2JVencTLgE/8SiLt2VOrNFfs4TnE0E5Q+zccBEQQBLW8KBhz
         t3hsXcB9CpbQ/VnW/A5nkRQLhUWLzvmT06E53v9STt9l067AeN2pXrKeigEYSTAKIH8T
         0n8A==
X-Gm-Message-State: ALoCoQnJ6aRisGr78GwVJSTLa/G1O3Dh9oKmbhQ+wYbX0EHuNhUlG2S8hQ5QXRegt1it4QJxMCc1
X-Received: by 10.224.136.129 with SMTP id r1mr8313385qat.60.1401902686789;
        Wed, 04 Jun 2014 10:24:46 -0700 (PDT)
Received: from [172.18.24.70] ([8.25.196.25])
        by mx.google.com with ESMTPSA id q10sm5078278qah.9.2014.06.04.10.24.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 10:24:46 -0700 (PDT)
In-Reply-To: <538EB748.3050300@viscovery.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250748>

On Wed, 2014-06-04 at 08:06 +0200, Johannes Sixt wrote:

> > +receive.denyCaseCloneBranches::
> > +	If set to true, git-receive-pack will deny a ref update that creates
> > +	a ref which is the same but for case as an existing ref.  This is
> > +	useful when clients are on a case-insensitive filesystem, which
> > +	will cause errors when given refs which differ only in case.
> 
> Shouldn't this better be named 'receive.denyCaseCloneRefs'?

Yes.  I'll fix that.

> How about 'denyCaseInsensitiveRefs', 'denyIgnoreCaseRefs'?

I don't love these, because it's not the case-insensitivity that's being
denied but the duplication. 

> Is this entry really so important that it must be the first in the list of
> receive.deny* list, which is not alphabetically sorted?

I think the list should be sorted alphabetically, so that we don't have
to worry about what is most important. 

<snip issues that I'll fix when I reroll>

> BTW, on a case-insensitive file system, is there not a chance that 'git
> rev-parse CaseClone' succeeds even though the ref is stored in
> victim/.git/refs/heads/caseclone? Perhaps you should inspect the output of
> 'git for-each-ref' for the expected result? (Mental note: At least a
> case-preserving file system is required to run the test.)

I'll look into that and fix if necessary.  Thanks.

<snip more issues that I'll fix when I reroll> 
