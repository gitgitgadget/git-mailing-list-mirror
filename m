From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 14:45:29 -0700
Message-ID: <d411cc4a0808191445o22eb57b5tfaa37d715524f55a@mail.gmail.com>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
	 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
	 <20080819185804.GA17943@coredump.intra.peff.net>
	 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
	 <20080819190832.GC17943@coredump.intra.peff.net>
	 <20080819195928.GB24212@spearce.org>
	 <d411cc4a0808191326s35a56c1i2e20d82e3885298@mail.gmail.com>
	 <20080820062636.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: "=?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?=" 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 23:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVZ2C-0006r3-LL
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 23:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYHSVpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 17:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbYHSVpc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 17:45:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:23794 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYHSVpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 17:45:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so47736yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CFDah8DCmjalTk//6YVZY+d4ian9k6ddnEUsyiYu5nM=;
        b=fCilKE3csh1TRy4eqH5zPNhBiUtXJcez6wD2WLlgkwhUTrmJwoMDJP54TiWjZ4eM1E
         S/p7C1jbm/vn/zoT+Uf2dujAuDifIi8bLfTbWuNgeTYLAf1eEsuU2sv6vpmhzDxmd8gj
         5vxMjkiTNCVzxiQ2fQxkZmmAOulS08lA/AuXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hdTjKyBKDKtg2eHzxkZSyI6LzIEmWT56vazBEAQ2VaKyg1uyLfvW9ns8ZaLBWjR/nF
         bSO8pKh0h9EvNQ3xOFRLwHLMd10H+Bt/IWV9MKpAG1RhT7WOgGdYQrxzTM2yWSuKYfPC
         fpxucpZKYUprZ4l63Z/WxUzZ02ifm9f5KWJ4U=
Received: by 10.114.77.19 with SMTP id z19mr7290905waa.138.1219182329446;
        Tue, 19 Aug 2008 14:45:29 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 14:45:29 -0700 (PDT)
In-Reply-To: <20080820062636.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92925>

On Tue, Aug 19, 2008 at 2:26 PM, しらいしななこ <nanako3@lavabit.com> wrote:
> Quoting Scott Chacon <schacon@gmail.com>:
>
>> On Tue, Aug 19, 2008 at 12:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>> Jeff King <peff@peff.net> wrote:
>>>>
>>>> One other argument I have seen is that, to prevent the proliferation of
>>>> hooks, the rule is not to add a hook that could just as easily be done
>>>> as a sequence of commands. IOW, what's wrong with
>>>>
>>>>   run_my_automated_tests && git push
>>>
>>> Yup, I agree completely.
>>>
>>> Why not just setup an alias:
>>>
>>>        git config alias.send '! run_my_tests && git push "$@"'
>>>
>>> and retrain your fingers to use "git send ..."?
>>
>> Sorry, but couldn't this argument be made about any of the hooks run
>> after manual operations?  ie: pre-commit, pre-applypatch, commit-msg,
>> post-commit, post-applypatch?  I mean, couldn't you do :
>>
>> git config alias.docommit '! do_pre_commit && git commit ...' ?
>>
>> I thought the point of these kind of hooks was to make stuff like this
>> automatic and easy to standardize for a project, so people working on
>> a dozen git repos don't have to remember all the aliases they set up
>> in each one.
>
> This topic seems to come up every once in a while.
>
>  http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=71069
>  http://thread.gmane.org/gmane.comp.version-control.git/79306/focus=79321
>
> Somebody needs to describe the general rules in SubmittingPatches, perhaps?
>
> I do not understand why Junio said he thinks this pre-push hook is a good idea.  This clearly is "you always would want to do before running a git command" case.
>
> --
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
>

I don't think I understand how this is different than 'pre-commit'
(or, alternatively, how this does not fall under #1 in that list).  If
the script exits non-0, it stops the push, isn't that exactly what
pre-commit does, but with 'push' instead of 'commit'?

Scott
