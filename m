X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 11:45:56 +0200
Message-ID: <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
References: <200610261641.11239.andyparkins@gmail.com>
	 <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
	 <200610270827.17659.andyparkins@gmail.com>
	 <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	 <20061027081545.GF29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:46:15 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cB8Pw9T0CtwIr+6mOdFuBIRsTwYyU27Sx9sNwtmU3SIAj+YJJJEpT946vnv3cJkEZg3g3TeztoUMzahyOzOmzLnd+DzlW+L2dxovMEeIZVPk2TKFpabOuFvQdHguTqqsa4YuXWSED2VdyG8yi0dKC/ktQZb+W2QSZU4m2SGy944=
In-Reply-To: <20061027081545.GF29057@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30317>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdOHr-0002HX-KJ for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946070AbWJ0Jp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946294AbWJ0Jp6
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:45:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21844 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946070AbWJ0Jp6
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:45:58 -0400
Received: by ug-out-1314.google.com with SMTP id 32so632325ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 02:45:57 -0700 (PDT)
Received: by 10.78.165.16 with SMTP id n16mr4569668hue; Fri, 27 Oct 2006
 02:45:56 -0700 (PDT)
Received: by 10.78.128.2 with HTTP; Fri, 27 Oct 2006 02:45:56 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

>> >Which leads us to the always interesting, fun and exciting:
>> >
>> >    git ls-tree -r HEAD | git update-index --index-info
>> >
>> >which will undo everything except 'git add' from the index, as
>> >ls-tree -r is listing everything in the last commit.
>> >
>>
>> ... and also shows The Power of the Pipe, which Daniel@google was
>> missing in recent versions of git. ;-)
>>
>> Btw, this is most definitely not a documented thing and requires a bit
>> of core git knowledge, so perhaps the "shell-scripts were good for
>> hackers to learn what to pipe where" really *is* a very important point.
>
> Agreed.

Still, it is very impressive, it is supported (and will be supported, I assume),
and as such - worth mentioning at least in these examples everyone keeps
dreaming about. Until that happened, why not mention that the output
of "git ls-tree" is compatible with --index-info of "update-index"?

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index f283bac..0ab9913 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -64,6 +64,8 @@ Output Format

 When the `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
+This output format is compatible with what "--index-info --stdin" of
+git-update-index expects.


