X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Sometimes "Failed to find remote refs" means "try git-fetch --no-tags"
Date: Tue, 14 Nov 2006 19:53:34 -0800
Message-ID: <f2b55d220611141953t48d81ac5q4f48183ae79ba0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 03:53:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JyP59/y1+OpTIChTSfLLR6cVMRgALTSKB73VHUZYEgfRpUfgAHjjFj9hSSQMb0Sq+su9252djrWbsBpRTHCuAEdAorYao+E1/6vwhy7nug+EquBFCqe23Y+02vfmAmAvPB8xGySyhAJkAU87DVvbgbsO3znxOwV9Fc94cGodIOM=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31407>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkBqF-0003Ot-El for gcvg-git@gmane.org; Wed, 15 Nov
 2006 04:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966076AbWKODxg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 22:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966101AbWKODxg
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 22:53:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:6807 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S966076AbWKODxf
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 22:53:35 -0500
Received: by wx-out-0506.google.com with SMTP id i31so70705wxd for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 19:53:34 -0800 (PST)
Received: by 10.90.75.10 with SMTP id x10mr1661895aga.1163562814711; Tue, 14
 Nov 2006 19:53:34 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Tue, 14 Nov 2006 19:53:34 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Down inside git-ls-remote there is a die "Failed to find remote refs".
 This struck when I tried to fetch an http repository with a missing
info/refs file.  Using "git fetch --no-tags" succeeds because it
doesn't have to call git-ls-remote at all.  Does git-ls-remote have
any way of knowing who is calling it so that it can print a
context-appropriate error message?  If not, is it worth adding some
sort of "caller context" mechanism, perhaps at the boundary between
porcelain and plumbing?  Or should the error message include, "If you
were trying to do a 'git fetch', try --no-tags; you won't get tags but
you may get a good update of the branch content"?

Cheers,
