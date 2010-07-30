From: Thomas Rast <trast@student.ethz.ch>
Subject: t4111 fails under valgrind
Date: Fri, 30 Jul 2010 12:18:52 +0200
Message-ID: <201007301218.52437.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 12:19:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oemg7-0006Uw-B8
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 12:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab0G3KSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 06:18:55 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:46809 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab0G3KSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 06:18:54 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 12:18:53 +0200
Received: from thomas.site (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 12:18:53 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152237>

Hi Jonathan

t4111 never worked under valgrind on my machine, building 9f41a91 and
then running it with --valgrind results in:

  expecting success: 
          cp postimage expected &&
          reset_subdir preimage other &&
          (
                  cd sub/dir &&
                  test_must_fail git apply --index "$patch"
          ) &&
          reset_subdir other preimage &&
          (
                  cd sub/dir &&
                  test_must_fail git apply --index "$patch"
          ) &&
          reset_subdir preimage preimage &&
          (
                  cd sub/dir &&
                  git apply --index "$patch"
          ) &&
          git show :sub/dir/file >actual &&
          test_cmp expected actual &&
          test_cmp expected sub/dir/file

  error: sub/dir/file: does not match index
  error: sub/dir/file: does not match index
  error: sub/dir/file: does not match index
  not ok - 5 apply --index from subdir of toplevel
  #
  #               cp postimage expected &&
  #               reset_subdir preimage other &&
  #               (
  #                       cd sub/dir &&
  #                       test_must_fail git apply --index "$patch"
  #               ) &&
  #               reset_subdir other preimage &&
  #               (
  #                       cd sub/dir &&
  #                       test_must_fail git apply --index "$patch"
  #               ) &&
  #               reset_subdir preimage preimage &&
  #               (
  #                       cd sub/dir &&
  #                       git apply --index "$patch"
  #               ) &&
  #               git show :sub/dir/file >actual &&
  #               test_cmp expected actual &&
  #               test_cmp expected sub/dir/file
  #

Any ideas what might be going wrong?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
