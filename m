From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [BUG] git completion do sed on binary file
Date: Tue, 19 Aug 2008 19:27:39 +0700
Message-ID: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 14:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVQKM-0002gA-J6
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 14:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYHSM1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 08:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYHSM1m
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 08:27:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:13925 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYHSM1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 08:27:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1957544fgg.17
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oU7Abj5uP6BSvCHULz8RUywrKE0FHmAedg2DxHzdlHk=;
        b=f5F0+4VJBvGRcs1HWLJBviu2MswMnWALxJBQuqb4YFv9nnlBjqTM7/dWFK5EzHbJb3
         hOthl3pQSVKWa/bQvmiRTvtQl+N3Te27pLzzJwbGXTEYPLraOnBQ5+dVMQEW1NiJfM41
         IZGQiOm5iH3iMzyy2zTrt9gKszZTXBmJPux6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=sjzYQrZsgTsaZTfpVuBOXjatpoggJY/ajtWrjGj3wB8m2nJDqrNUdfdjZMrp6ZBWEL
         esk2+LGcHVlZjXKkwHpbhvHQr8LR1U7FqxsB5N836owsh5BCCyJ2ASOKbCFrfckUUH9g
         pd04dZhvkIMoGNr7Z8UT5OqeJx0zlzdlyxeqw=
Received: by 10.86.79.19 with SMTP id c19mr5486556fgb.79.1219148859958;
        Tue, 19 Aug 2008 05:27:39 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Tue, 19 Aug 2008 05:27:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92851>

Probably missed since git-merge builtin effort:

__git_merge_strategies ()
{
        if [ -n "$__git_merge_strategylist" ]; then
                echo "$__git_merge_strategylist"
                return
        fi
        sed -n "/^all_strategies='/{
                s/^all_strategies='//
                s/'//
                p
                q
                }" "$(git --exec-path)/git-merge"
}

It takes several seconds to finish that function.
-- 
Duy
