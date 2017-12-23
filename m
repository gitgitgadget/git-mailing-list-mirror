Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6691F406
	for <e@80x24.org>; Sat, 23 Dec 2017 00:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756548AbdLWAYB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 19:24:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:61543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdLWAYA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 19:24:00 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lv8hi-1fAz3g2Nlq-010OSJ; Sat, 23
 Dec 2017 01:23:54 +0100
Date:   Sat, 23 Dec 2017 01:23:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] oidmap: ensure map is initialized
In-Reply-To: <20171222232729.253936-1-bmwill@google.com>
Message-ID: <alpine.DEB.2.21.1.1712230118340.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com> <20171222232729.253936-1-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UWnJ8MnHe7JW4+5dnnYGxPW4vylW7UsicpJg2O6zC72c9ZnBuXu
 uRmZmJEbs1H84YVIcz6VUnaAEv5S1NoTuvU8fh/eHcxoqMLQBM7OGAaN+7D1/dZDe5RpQbH
 jcirnR47uHGXHYhd0WiMXN2MI4XZ40amUaW9i67ICRACPH8vSZiNLkluQK2SsjoAi8xnUL5
 mh1eFQC0g4se0EzvxKaMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GQ1MzU4mLJE=:IjNhazcE+xSFJSOHcSozRX
 OYRrTRK22SHhMe+CthIZpCI7gY7KtBGyeRUTQhP0Nu+ZB1KFeTzgDes2BBxkWskiN/D50lcve
 LsqOJjMPGP381ui397u4JbCnNmpyqjmWSJjuzMUV0yZGhItt1hyWaB7K3YE6KNNOarO+MSh7D
 Q+LlwdgC23vNXxydismRmUF+W6TCkkap2JjJN8HVut196sQFF0ePtoz4ikngXRvNzYaSTGr7I
 3Fy+wdAQgGcro0q4wYEEv/nH7pOSb2oI7izpPLy/NPuZVadvQwY7H0I1YF+sB/cvy2V1zgENW
 HgP02XCYja+sfKWXNdLF+1XmAvMETOaZUAaMI4Km/KVxXYbu9g5RluGrcqTftmUSkzxeEqkdj
 jTgEzXj4Il7XAh5XoSaYjsv4OUmPbbrTMjG/qVxWrkf9HtnIMD5B+RH5uOaIhU/T9fcRkvQ0y
 GQAQM7ul4C8r8B3JfqdBl/kFcGNDWCKDILNotyiiXhAJ0jCLs0N8siVwYPqH+2Gi2nNLoLwXZ
 0dGJhSpz4Dsz+dyIv+YzFlIRGqomkm/hFoqvsR2n0I1nJL37Bn1foT343BUvI9D0GBA8QqWz7
 wnzkBHYNx/Sgd0jchuP56S5Mt3lSeaMffB1jq04nvZ7TeKmuWsxlxpuusBEljziP18hhgBYeE
 X0IQkibjB1TLQJnsINayx1hhBfIzTSatem6FGadCFRpxkExS95qvBWwM7mHMNqqIjFZII4DWh
 0b9f7aE0VLuYhuz3O4UfJX6ENoG7gfDE3BAsKfqpQTQVUHRgu8uuBPeuU8fSb8E0uCwKOoo93
 671TWjKWo0OwF5oP7mmwLa9gKLIcgw33EfzKTutEMdjo8hC8q8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Fri, 22 Dec 2017, Brandon Williams wrote:

> Ensure that an oidmap is initialized before attempting to add, remove,
> or retrieve an entry by simply performing the initialization step
> before accessing the underlying hashmap.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  oidmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/oidmap.c b/oidmap.c
> index 6db4fffcd..d9fb19ba6 100644
> --- a/oidmap.c
> +++ b/oidmap.c
> @@ -33,12 +33,19 @@ void oidmap_free(struct oidmap *map, int free_entries)
>  
>  void *oidmap_get(const struct oidmap *map, const struct object_id *key)
>  {
> +	if (!map->map.cmpfn)
> +		return NULL;
> +

This one is unnecessary: if we always _init() before we add, then
hashmap_get_from_hash() will not have anything to compare, and therefore
not call cmpfn.

You could argue that it is only a teeny-tiny runtime cost, so it'd be
better to be safe than to be sorry.

However, it is a death by a thousand cuts. My colleagues and I try to
shave off a few percent here and a few percent there, in the hope to get
some performance improvements worth writing home about. And then patches
like this one come in that simply add runtime without much in the way of
performance considerations.

And that makes me quite a bit sad.

>  	return hashmap_get_from_hash(&map->map, hash(key), key);
>  }
>  
>  void *oidmap_remove(struct oidmap *map, const struct object_id *key)
>  {
>  	struct hashmap_entry entry;
> +
> +	if (!map->map.cmpfn)
> +		oidmap_init(map, 0);
> +
>  	hashmap_entry_init(&entry, hash(key));
>  	return hashmap_remove(&map->map, &entry, key);
>  }
> @@ -46,6 +53,10 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
>  void *oidmap_put(struct oidmap *map, void *entry)
>  {
>  	struct oidmap_entry *to_put = entry;
> +
> +	if (!map->map.cmpfn)
> +		oidmap_init(map, 0);
> +
>  	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
>  	return hashmap_put(&map->map, to_put);
>  }

"But it does not add a lot, it's only a couple of microseconds"

Sure. But we could (and do) simply initialize the hashmaps once, and avoid
having to spend unnecessary cycles for every single access.

I *much* prefer my original patch that essentially does not change *any*
code path. Everything stays the same, except that there is now a strong
hint explaining why you need to call oidmap_init() manually instead of
using the OIDMAP_INIT macro and then wonder why your code crashes.

Ciao,
Dscho
