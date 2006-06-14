From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: oprofile on svn import
Date: Tue, 13 Jun 2006 21:10:19 -0400
Message-ID: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 14 03:11:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqJvB-00032w-Gl
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 03:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWFNBK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 21:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWFNBKi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 21:10:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:13134 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964854AbWFNBKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 21:10:21 -0400
Received: by nz-out-0102.google.com with SMTP id s18so15455nze
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 18:10:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PvY4NgTJd2HFsLAWvSQMSHfxdVgu2kDeCQ5i8OaycHw717TmlpFieY+aDtdbmsXqO6wcAk6WiFhfDHZwY3PaYpO95BsUCsqTaveTNfRtN4Uy6EcXpF/yl1eBqmMRRXFPgWh4DcZ9dkgX08aT0Ub0GFiTwnLYBz4peffGtXTXjkw=
Received: by 10.36.36.19 with SMTP id j19mr156079nzj;
        Tue, 13 Jun 2006 18:10:20 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Tue, 13 Jun 2006 18:10:19 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21819>

I'm going back to cvsimport tomorrow. My svn import that had been
running for five days got killed this morning when the city decided to
move the telephone pole that provides my electricty.

Some oprofile data, this doesn't make a lot of sense to me. Why is it
in libcypto so much?

 12632739 30.6077 /lib/libcrypto.so.0.9.8a
 11762639 28.4995 /home/good/vmlinux
  6310191 15.2889 /lib/libc-2.4.so
  2498812  6.0543 /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/libperl.so
  2079975  5.0395 /usr/local/bin/git-update-index
  1103116  2.6727 /usr/lib/libz.so.1.2.3
   617395  1.4959 /usr/lib/libapr-1.so.0.2.2
   484625  1.1742 /usr/local/bin/git-read-tree

kernel breakdown

2035561  16.4450  copy_page_range
1110813   8.9741  get_page_from_freelist
851064    6.8756  check_poison_obj
759296    6.1342  unmap_vmas
670659    5.4181  release_pages
667657    5.3939  page_remove_rmap
595826    4.8136  page_fault
241962    1.9548  __copy_from_user_ll
185876    1.5017  do_wp_page
176506    1.4260  do_page_fault


I reset the statistics and took another snapshot half an hour later.

  2232310 44.3485 /home/good/vmlinux
   757114 15.0413 /lib/libcrypto.so.0.9.8a
   507282 10.0780 /lib/libc-2.4.so
   203440  4.0417 /usr/lib/libz.so.1.2.3
   179105  3.5582 /usr/lib/libapr-1.so.0.2.2
   169724  3.3718 /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/libperl.so
   114384  2.2724 /usr/local/bin/git-update-index
   102350  2.0334 /usr/lib/libsvn_subr-1.so.0.0.0
    74673  1.4835 /usr/lib/libaprutil-1.so.0.2.2
    69987  1.3904 /usr/lib/libsvn_fs_fs-1.so.0.0.0

Kernel:

543264   21.2518  copy_page_range
243383    9.5208  check_poison_obj
227788    8.9108  unmap_vmas
161806    6.3296  page_remove_rmap
153201    5.9930  release_pages
119092    4.6587  page_fault
100116    3.9164  get_page_from_freelist
45014     1.7609  do_wp_page
42130     1.6481  vm_normal_page
34804     1.3615  poison_obj
28231     1.1044  do_page_fault
27403     1.0720  __handle_mm_fault
24558     0.9607  __copy_to_user_ll
20618     0.8066  flush_tlb_page


-- 
Jon Smirl
jonsmirl@gmail.com
