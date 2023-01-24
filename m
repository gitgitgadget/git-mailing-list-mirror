Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D33C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjAXOxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjAXOxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:53:53 -0500
X-Greylist: delayed 152427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 06:53:50 PST
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [95.163.41.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506B4995C
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=krbMdIIfMSXBIhlxMbRgEiLsF1IcrSVCHgx2LFRpnlE=;
        t=1674572030;x=1674662030; 
        b=IXaF9+WqKDIO9U7DeLY0fbcWll8llUwWaXkgUqGBEVLeCTPkw0vLXy9IC0Z7Fos2Qbamdh8yVoFg0B13XFCCX/yBzZeqARICXKsT88oR5fLDlApB8RHF/vFNGpi2WwX9q9pmJzZ4lh4KHDWmOerIYHCUbrWbcbp6FAnckOQS9Y2tDpyCqYT9f94YOnlIf7fGEY4oY6SRVGn1kaaS396wC+4gbLkZE3KAGN0oWIJ0SncgNIKoK+IS7twA96uqArfbG52e0MAlrm33vZDC2R2nBH2ZTuMGBh/QgUFN4tVYHubTEtmw2xnZEEFq0fif2vVAEXj1nUXZWEJ73SPnpWUJzg==;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pKKgG-00BSGG-3u; Tue, 24 Jan 2023 17:53:48 +0300
Date:   Tue, 24 Jan 2023 17:54:36 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1204599253.20230124175436@inbox.ru>
To:     Emily Shaffer <nasamuffin@google.com>
CC:     git@vger.kernel.org
Subject: Re: nested submodules detection w/o .gitmodules file
In-Reply-To: <CAJoAoZkjfOQwkeQqzQY5qDo7Md5QWSz1pOTBQKHL5KwNu2VoDg@mail.gmail.com>
References: <1716310675.20230122233403@inbox.ru> 
  <CAJoAoZkjfOQwkeQqzQY5qDo7Md5QWSz1pOTBQKHL5KwNu2VoDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp36.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A6D6F5724DD3A0B60E915A56FB921C50CC0C40CAEDEC64A7182A05F5380850407245D911DE1F28EA19180A079FF9E4EDBE25BD1C93C8468A591577E193EBB924
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E8204D72912C702FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377A06FA5CCF78F9BC8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D886490BC69EAD37597F5AFEBB8619453E6F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC292D688DDAD4E7BC389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8DA7BFA4571439BB2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCEBC872EF0A1BB65302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3D6B8D1F75A55B56D3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735B25CBF701D1BE873C4224003CC83647689D4C264860C145E
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34F7CC4EA888783AE047FC4B7BFFED5038BF821EF8DABD69BE11D04F6B1EFA7404037F0F80A6B9C21E1D7E09C32AA3244C364DBD7A113377BEB3EEE0C4DE96B55D8A6D4CC6FBFAC251729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj4ukhBIi/0FDdVLf1z4oQJg==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E0786AE8CEFED340519180A079FF9E4ED0ED2FDEC15CED16958EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Emily,



Monday, January 23, 2023, 11:12:32 PM, you wrote:

ES> There is a little nuance here. Git can have nested repositories in a few different ways; submodules are just one of them.
ES> A submodule is the combination of a gitlink object in the object graph *and* a corresponding entry in the .gitmodules file.
ES> It's certainly possible to embed a nested repository in other ways, such as by ignoring the .gitmodules file, but then your
ES> nested repository is no longer a submodule, and operations which recurse over submodules will not consider that nested repository.

But it does consider. See the output of the `git submodule summary` command:
https://github.com/gitextensions/gitextensions/discussions/10644#discussioncomment-4688533

ES> The reason is that we need to understand where to clone the submodule from - that information isn't contained in the superproject's
ES> repository URL

Yes, it does clone "externally", but after a clone it is contained in the `.git/config` of a subproject:

[submodule]
        active = .
[remote "origin"]
        url = ...

ES> , and it can't be contained in the gitlink directly (which is in essence just a commit object, but one that exists
ES> in the nested repository, not in the superproject repository). If we didn't have a way of writing down the submodule's remote URL
ES> and version controlling it, we wouldn't have a way to populate the submodules when a user is cloning.

The `git submodule summary` nevertheless can populate submodules after that, so this is not the matter.

ES> The .gitmodules exists to help at clone time; it's possible, as I
ES> think you're pointing out, to have some intermediate state locally.
ES> But this file is what needs to be the source of truth for putting
ES> together the repository on a new machine for the first time.

Yes, the original clone command is superseded in those projects.

