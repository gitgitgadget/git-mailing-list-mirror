From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe
 to do so
Date: Thu, 6 Oct 2011 13:21:40 -0400
Message-ID: <CAG+J_Dzh2Njjwykt-f4w_YqpftrJEpQfUW2OvSRs_MSPcNFQnw@mail.gmail.com>
References: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
	<7vty7m12b2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:21:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrdj-0002jO-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706Ab1JFRVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:21:42 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51832 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab1JFRVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:21:41 -0400
Received: by ggnv2 with SMTP id v2so1935064ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U6v7zIMPQrxude0Ths01YetxZjuDdqhetnD9NAlukA4=;
        b=l7WbuY8OASis6TjfcY4i8bmaY4Wu7ElNGcXFYlejwzdnMTnxmPNMKMJ+bdXvy4dH3m
         gYRiugjBA7TsAVWGIuHMas0V7nXJrMRRHNco99tfOqK7NIOvsc/SgArIkBrPFYUqPay2
         /a5FMf+60tfz9xIbKwKPIn8PL1Md/RljtE6js=
Received: by 10.147.5.21 with SMTP id h21mr731656yai.26.1317921701160; Thu, 06
 Oct 2011 10:21:41 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 10:21:40 -0700 (PDT)
In-Reply-To: <7vty7m12b2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182987>

On Thu, Oct 6, 2011 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think do_recursive_merge() would die() when the merge cannot even start
> (i.e. the local changes after the cherry-pick exits are the ones from the
> time before such a failed cherry-pick started), but I suspect that the
> other codepath uses try_merge_command() to drive strategies other than
> recursive and it does not die() there in such a case. Can you make sure
> this patch is sufficient in such a case as well?

Why does recursive die with a dirty tree but not other strategies?

For that matter, why does revert.c have it's own implementation of
recursive instead of just calling try_merge_command("recursive", ...)?

j.
