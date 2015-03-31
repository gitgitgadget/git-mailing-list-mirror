From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git ls-files wildcard behavior considered harmful
Date: Tue, 31 Mar 2015 07:35:24 +0700
Message-ID: <CACsJy8C9VdpN2MoNC7-ZuLAvjV5fUZVLzMM-gUzjj1ZQ5r9Vtg@mail.gmail.com>
References: <20150330230459.GA13927@kitenet.net> <CACsJy8BDoXHS6nj7pEe0i8T=bMD8aG5FwuXABKgPOQBeMOr+Vw@mail.gmail.com>
 <20150330233614.GA17089@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 31 02:36:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yck9w-00012j-Qn
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 02:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbbCaAf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 20:35:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34085 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbbCaAf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 20:35:56 -0400
Received: by igcau2 with SMTP id au2so3105685igc.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ts48KmaqAmlZCePJOyHEG9MtgFc81NDtpJ0OudfKzzM=;
        b=Ky/iaUnoFdv7HWr5pzz/YtorZh1aFxvx4TSSi1bfN7ie7cUfz7vzFiG9Eq+GEDVlw5
         CRxM0SoV9bduCgQm8SYNtV3SCn4zkKaMtLw4gpnSA398b7/By6p0ay5FHoohmllg0qbz
         kMmu2EjMt8GV1CsM392Mp7bkBv8oOvxSQx+mZNODjoTL4511HfD2VxUo5fmprkfegaQL
         uB2LO4tWD3r/wZk8NoAuLVc2WSQcf4zlU/wNNnv2Xn8MVOaxvv4CY1EESDdHQ1KgRTX+
         SZLXR2yg5RZKuFy38wtakaZzboRzOavspg9NL3DWSCRPjdl7dZXvxC9NT6GrJw1HoXhd
         WlSQ==
X-Received: by 10.107.133.16 with SMTP id h16mr51909111iod.31.1427762155672;
 Mon, 30 Mar 2015 17:35:55 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 30 Mar 2015 17:35:24 -0700 (PDT)
In-Reply-To: <20150330233614.GA17089@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266493>

On Tue, Mar 31, 2015 at 6:36 AM, Joey Hess <id@joeyh.name> wrote:
> Duy Nguyen wrote:
>> You can do "git --literal-pathspecs ls-files ..." or set GIT_LITERAL_PATHSPECS.
>
> Thanks! --literal-pathspecs does allow getting around this.
>
> Now I'm wondering what other parts of plumbing might be doing globbing
> that I did not anticipate. Maybe I should set the environment variable
> so I don't need to worry about it..

We're just a bit sloppy in documentation. ls-files learned about
wildcards since 56fc510 ([PATCH] git-ls-files: generalized pathspecs -
2005-08-21). Two months later, git-ls-files.txt is updated to say
"<file>" (which is not entirely correct even if we ignore wildcards,
ls-files can take directories as well). With latest git, I think only
git-mv and git-read-tree go with plain paths. It's probably best to
set GIT_LITERAL_PATHSPECS for scripting like Jeff said.
-- 
Duy
